import tensorflow as tf
from tensorflow.keras import layers as tf_layers
import roslibpy
import numpy as np
import sys
import time
import argparse
import os
from roslib_logger import log_node


NUM_STATES = 150
NUM_OUTPUT_NODES = 200  # 100 notes corresponds to the percent power to motor + 100 and - 100

# Training configuration
EPSILON_DISCOUNT = 0.95

# Model saving
MODELS_DIR = 'C:/Users/borge/MARSHA/models/'
MODEL_NAME = 'nnController'

def displace(list, value):
    list.pop(0)
    list.append(value)
    return list

class simp_nn:
    def __init__(self):
        physical_devices = tf.config.list_physical_devices('GPU')
        tf.config.experimental.set_memory_growth(physical_devices[0], enable=True)    

        self.model = tf.keras.Sequential()
        self.model.add(tf_layers.Dense(units=10, input_shape=(2,), activation='sigmoid'))   
        self.model.add(tf_layers.Dense(units=10, input_shape=(2,), activation='sigmoid')) 

# Perhaps splitting into two models will perform better
# Note: Not currently implemented
class nn2:
    def __init__(self):
        physical_devices = tf.config.list_physical_devices('GPU')
        tf.config.experimental.set_memory_growth(physical_devices[0], enable=True)

        self.state_model = tf.keras.Sequential()
        self.state_model.add(tf_layers.LSTM(units=10, return_sequences=True, input_shape=(1,)))
        self.state_model.add(tf_layers.Dropout(0.2))
        self.state_model.add(tf_layers.LSTM(units=10, return_sequences=True))
        self.state_model.add(tf_layers.Dropout(0.2))
        self.state_model.add(tf_layers.Dense(units=1, activation='sigmoid'))
        self.state_model.compile(optimizer='adam', loss='mse')

        self.sp_model = tf.keras.Sequential()
        self.sp_model.add(tf_layers.Dense(units=150, input_shape=(2,), activation='sigmoid'))
        self.sp_model.add(tf_layers.Dense(units=200, activation='sigmoid'))
        self.sp_model.add(tf_layers.Dense(units=NUM_OUTPUT_NODES, activation='softmax')) #sigmoid?
        self.sp_model.compile(optimizer='adam', loss='mse')
# ------------------------------------------------------------------ #


class nn(tf.keras.Model):
    def __init__(self):
        physical_devices = tf.config.list_physical_devices('GPU')
        tf.config.experimental.set_memory_growth(physical_devices[0], enable=True)

        super(nn, self).__init__()
        self.lstm1 = tf_layers.LSTM(units=10, return_sequences=True, input_shape=(1,))
        self.lstm2 = tf_layers.LSTM(units=10, return_sequences=True)
        self.lstm3 = tf_layers.LSTM(units=10, return_sequences=True)
        self.lstm4 = tf_layers.LSTM(units=10, return_sequences=True)
        self.state_dense1 = tf_layers.Dense(units=1, activation='sigmoid')
        self.flatten = tf_layers.Flatten()
        self.sp_dense1 = tf_layers.Dense(units=150, activation='sigmoid')
        self.concat = tf.keras.layers.Concatenate(axis=-1)
        self.dense1 = tf_layers.Dense(units=150, input_shape=(2,), activation='sigmoid')
        self.dense2 = tf_layers.Dense(units=200, activation='sigmoid')
        self.dense3 = tf_layers.Dense(units=200, activation='sigmoid')
        self.dense4 = tf_layers.Dense(units=200, activation='sigmoid')
        self.dense5 = tf_layers.Dense(units=NUM_OUTPUT_NODES, activation='softmax') #sigmoid?

        self.drop = tf_layers.Dropout(0.2)


    def call(self, input):
        x = self.lstm1(input['state'])
        x = self.drop(x)
        x = self.lstm2(x)
        x = self.drop(x)
        x = self.lstm3(x)
        x = self.drop(x)
        x = self.lstm4(x)
        x = self.drop(x)
        x = self.state_dense1(x)
        st_x = self.flatten(x)
        sp_x = self.sp_dense1(input['sp'])
        x = self.concat([st_x, sp_x])
        x = self.dense1(x)
        x = self.dense2(x)
        x = self.dense3(x)
        x = self.dense4(x)
        x = self.dense5(x)
        return x

    # target is a one hot calculation between reward and the chosen action

# need to change this to arg
HOST = '192.168.155.22'
PORT = 9090


class Network(object):
    def __init__(self, num_episodes):

        # ------------------------ ROS setup --------------------- #
        self.ros = roslibpy.Ros(host=HOST, port=PORT) 
        self.ros.connect()
  
        self.num_episodes = int(num_episodes) #self.ros.get_param("num_episodes")
        self.pub = roslibpy.Topic(self.ros, '/nn_out', 'std_msgs/Float64')

        self.pub_train_info = roslibpy.Topic(self.ros, '/train_info', 'marsha/TrainInfo')


        # Change this to generalize it
        setpoint_topic = roslibpy.Topic(self.ros, '/setpoint', 'std_msgs/Float64')
        setpoint_topic.subscribe(self.setpointCallBack) 

        state_topic = roslibpy.Topic(self.ros, '/state', 'std_msgs/Float64')
        state_topic.subscribe(self.stateCallBack)
        # --------------------------------------------------------- #

        self.log = log_node(host=HOST, port=PORT)

        self.oldsetpoint = 0
        self.setpoint = 0
        self.state = [0] * NUM_STATES

        # ------------------ Setup Model FileSystem --------------- #
        ids_file = open(MODELS_DIR + MODEL_NAME + '/model_ids')
        self.model_id = int(ids_file.read())
        ids_file.close()
        ids_file = open(MODELS_DIR + MODEL_NAME + '/model_ids', "w")
        ids_file.write(str(self.model_id + 1))
        self.model_id = str(self.model_id)
        os.mkdir(MODELS_DIR + MODEL_NAME + '/model' + self.model_id)
        # ---------------------------------------------------------- #


        # ---------------------- Training -------------------------- #
        # Only used when training
        self.training = True
        self.training_complete = False
        train_topic = roslibpy.Topic(self.ros, '/train', 'marsha/TrainData')
        train_topic.subscribe(self.trainCallBack)

        self.epsilon = 0
        self.episode_num = 0
        # Number of episode samples can differ depending on settling time
        self.episode_inputs = []  # array of input dicts
        self.episode_actions = []
        self.optimizer = tf.keras.optimizers.Adam(1e-4)
        self.mse = tf.keras.losses.MeanSquaredError()
        # ---------------------------------------------------------- #

        self.model = nn()

        self.ros.run()  

        #input_shape = rospy.get_param('input_shape')
        #output_shape = rospy.get_param('output_shape')


    # This class doesnt really need its own call function this can be put in run
    def call(self, input):
        # need to normalize
        action = None
        if self.training:
            # Boltzmann softmax distribution
            out = self.model(input)
            p_a_s = np.exp(self.epsilon * out)/np.sum(np.exp(self.epsilon * out))
            action = np.random.choice(a=NUM_OUTPUT_NODES, p=p_a_s[0]) 
            action = action - int(NUM_OUTPUT_NODES/2) # should change nn_out type to int later
            action = float(action)
            #print('acttion:', action)
            self.episode_inputs.append(input['state'])
            self.episode_actions.append(action)
        else:
            out = self.model(input)
            action = float(tf.math.argmax(out, 1) - int(NUM_OUTPUT_NODES/2)) # should change nn_out type to int later

        return action

    def _normalize(self, input):
        sp = input['sp']
        state = input['state']
        # normalize sp:
        sp = (sp + 360) / 720  
        state = (state + 360) / 720
        return {'sp':sp, 'state':state}


    def trainCallBack(self, trainData):
        targets =  trainData['targets'] # array with element for each sample
        # set sample size
        lengths = [len(targets), len(self.episode_actions), len(self.episode_inputs)]
        sample_size = min(lengths)

        if sample_size > 0:
            if lengths[0] > sample_size:
                targets = targets[:sample_size]
            if lengths[1] > sample_size:
                self.episode_inputs = self.episode_inputs[:sample_size]
            if lengths[2] > sample_size:
                self.episode_actions = self.episode_actions[:sample_size]


            targets = np.array(targets)

            sp_inputs = [self.oldsetpoint] * sample_size
            sp_inputs = np.array(sp_inputs)
            state_inputs = np.array(self.episode_inputs)

            sp_inputs = np.reshape(sp_inputs, newshape=(sample_size, 1))
            state_inputs = np.reshape(state_inputs, newshape=(sample_size, state_inputs.shape[2], 1))

            inputs = {'state': state_inputs, 'sp':sp_inputs}
            actions = np.array(self.episode_actions)

            self.episode_inputs = []
            self.episode_actions = []

            normalized = self._normalize(inputs)

            with tf.GradientTape() as tape:
                qs = self.model(normalized)
                #print('qs:', qs)
                action_masks = tf.one_hot(actions, NUM_OUTPUT_NODES) # creates numpy matrix, each row corresponds to a sample
                masked_actions = tf.reduce_sum(tf.multiply(qs, action_masks), axis=1)
                loss = self.mse(targets, masked_actions)
            grads = tape.gradient(loss, self.model.trainable_variables)
            self.optimizer.apply_gradients(zip(grads, self.model.trainable_variables))

            if self.episode_num % 10 == 0:
                self.model.save_weights(MODELS_DIR + MODEL_NAME + '/model' + self.model_id + '/checkpoint' + str(self.episode_num))

            if self.episode_num < self.num_episodes:
                if self.episode_num < self.num_episodes * EPSILON_DISCOUNT :
                    self.epsilon += EPSILON_DISCOUNT / self.num_episodes
            else:
                self.training_complete = True
                #self.log.info('Saving model' + self.model_id + '...')
                #self.model.save_weights(MODELS_DIR + MODEL_NAME + '/model' + self.model_id + '/final_checkpoint')
                self.log.info('--- Training Complete ---')
                self.log.fatal("Training Finished. Shutting down...")
            if not self.training_complete:
                formatted_loss = "{:.2f}".format(loss.numpy())
                self.log.info('[EP ' + str(self.episode_num) + ' ] Training loss: ' + formatted_loss + ' Epsilon: ' + "{:.2f}".format(self.epsilon))
                self.pub_train_info.publish({'loss': float(formatted_loss)})
            self.episode_num += 1
        else:
            self.log.warn('Not enough samples...')


    

    def setpointCallBack(self, msg):

        self.oldsetpoint = self.setpoint  # doesnt start training until setpoint has been changed
        self.setpoint = msg['data']
        #self.episode_inputs = []

    def stateCallBack(self, msg):

        self.state = displace(self.state, msg['data'])


    def run(self):
        while self.ros.is_connected and not self.training_complete:
            if self.setpoint is not None:
                state_input = np.array(self.state)
                state_input = np.reshape(state_input, newshape=(1, NUM_STATES, 1))
                sp_input = np.array(self.setpoint)
                sp_input = np.reshape(sp_input, newshape=(1, 1))
                input = {'state': state_input, 'sp':sp_input}
                normalized = self._normalize(input)
                action = self.call(normalized)
                self.log.debug('action: ' + str(action))
                self.pub.publish({'data': action})
                time.sleep(0.05)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Neural Network Controller')
    parser.add_argument("num_episodes", metavar="<command>")
    args = parser.parse_args()

    os.system("set ROS_IP=192.168.155.16")
    os.system("set ROS_MASTER_URI=http://192.168.155.22:11311")

    # put name_space args here
    try:
        net = Network(args.num_episodes)
        print('new process done')
        net.run()
    except KeyboardInterrupt:
        net.ros.terminate()
    except Exception as e:
        net.log.err(str(e))
        print(e)
