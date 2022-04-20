/*

* Calculates velocity of object given positions

*/

#include <ros/ros.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Vector3.h>

#include <std_msgs/Empty.h>
#include <std_srvs/Trigger.h>

#include <tf/tf.h>
#include <Eigen/Dense>
#include <cmath>

#include "marsha_ai/object_dynamics.h"
#include "marsha_ai/kalman_filter.h"

#include "marsha_msgs/PredictPosition.h"
#include "marsha_msgs/ObjectObservation.h"


#define REACH    0.3
#define NUM_ACCURACY_MEASUREMENTS 10



Vector3f msg_to_v3f(const geometry_msgs::Point& msg) {
    return Vector3f(msg.x, msg.y, msg.z);
}
tf::Vector3 msg_to_vector(geometry_msgs::Point point) {
    return tf::Vector3(point.x, point.y, point.z);
}

geometry_msgs::Vector3 vector_to_Vmsg(tf::Vector3 vector) {
    geometry_msgs::Vector3 msg;
    msg.x = vector.x();
    msg.y = vector.y();
    msg.z = vector.z();
    return msg;
}

geometry_msgs::Point vector_to_Pmsg(tf::Vector3 vector) {
    geometry_msgs::Point msg;
    msg.x = vector.x();
    msg.y = vector.y();
    msg.z = vector.z();
    return msg;
}

void print_vect(tf::Vector3 vect) {
    ROS_INFO("x: %f y: %f z: %f", vect.x(), vect.y(), vect.z());
}



tf::Vector3 eigen2tf(Vector3f vect) {
    return tf::Vector3(vect[0], vect[1], vect[2]);
}


class TrajectoryPredictor {
    private:
        ros::Subscriber object_position_subscriber;
        ros::Subscriber reset_subscriber;

        ros::ServiceServer prediction_ready_service;
        ros::ServiceServer predict_position_service;
        ros::ServiceServer observation_service;

        KalmanFilter* kf = new KalmanFilter();

        unsigned char kalman_initialized = 0;
        Vector3f initial_position;

        std::vector<float> accuracy; // Accuracy of the last n measurements 

        ros::Time previous_time;
        ros::Time initial_time;

        Vector3f a = Vector3f(0, 0, 0);

        std::vector<Vector3f> position_buffer;

        bool start_kalman_flag = false;

        bool ready = false;

        float sufficient_convergence;



        void reset_callback(const std_msgs::Empty::ConstPtr& msg) {
            kalman_initialized = 0;
            ready = false;
            accuracy.clear();
            position_buffer.clear();
            initial_time = ros::Time::now();
            ROS_INFO("--- Reset ---");
        }





        void position_callback(const geometry_msgs::Point& msg) {
            // Two positions are used to initialize the kalman. This way the velocity can be estimated
            // Using two initial positions give time for the ball to be reset
            if (kalman_initialized < 2) {
                initial_position = msg_to_v3f(msg);
                previous_time = ros::Time::now();
                kalman_initialized++;
            }
            else if (kalman_initialized == 2) {
                position_buffer.push_back(msg_to_v3f(msg));
                start_kalman_flag = true;

            }
            else {
                position_buffer.push_back(msg_to_v3f(msg));
            }
        }

        // Convert normtime on [0, 1] to ros::time where the object position at 0.5 norm time is closest to the arm.
        // Predict position with T(t) = x_0 + v*t +  0.5*a*t^2
        bool predictPosition(marsha_msgs::PredictPosition::Request &req,
                             marsha_msgs::PredictPosition::Response &res) 
        {
            tf::Vector3 base_position = tf::Vector3(0, 0, 0);

            Vector3f curr_pos = kf->current_position();
            Vector3f curr_vel = kf->current_velocity();
            ROS_INFO("curr pos: x: %f, y: %f, z: %f", curr_pos[0], curr_pos[1], curr_pos[2]);
            ROS_INFO("curr vel: x: %f, y, %f, z: %f", curr_vel[0], curr_vel[1], curr_vel[2]);
            ROS_INFO("accel: x: %f, y: %f, z: %f", a[0], a[1], a[2]);
            // Calculate time closest to end effector
            Searcher searcher(kf->current_position(), kf->current_velocity(), a);

            float delta_time = searcher.solve();
            ROS_INFO("time until closest pass: %f", delta_time);

            res.predicted_time.data = previous_time + ros::Duration(delta_time);



            // Calculate position of object along trajectory or de_norm time
            tf::Vector3 predicted_position = kf->tf_current_position() + delta_time * eigen2tf(curr_vel) + 0.5*eigen2tf(a)*delta_time*delta_time;


            // Convert tf vector3 to geometry_msgs Point
            geometry_msgs::Point position_msg;
            position_msg.x = predicted_position.x();
            position_msg.y = predicted_position.y();
            position_msg.z = predicted_position.z();
            res.position = position_msg;
            
            
            return true;
        }




        bool observe(marsha_msgs::ObjectObservation::Request &req,
                     marsha_msgs::ObjectObservation::Response &res) {

            Vector3f pos = kf->current_position();
            Vector3f vel = kf->current_velocity();

            geometry_msgs::Point pmsg;
            pmsg.x = pos[0];
            pmsg.y = pos[1];
            pmsg.z = pos[2];

            geometry_msgs::Vector3 vmsg;
            vmsg.x = vel[0];
            vmsg.y = vel[1];
            vmsg.z = vel[2];
            res.position = pmsg;
            res.velocity = vmsg;
            return true;
        }

        // Ready to predict if it has achieved sufficient convergence
        // It has converged if the average accuracy is less than the convergence threshold
        // TODO: determine if convergence has been achieved by comparing to the standard deviation instead of the avg
        bool hasConverged() {
            float sum = 0;
            for (int i = 0; i < accuracy.size(); i++) {
                sum += accuracy[i];
            }
            float avg = sum / accuracy.size();
            ROS_INFO("avg: %f, sufficient converge: %f", avg, sufficient_convergence);
        
            return avg < sufficient_convergence;;

        }

        bool readyToPredict(std_srvs::Trigger::Request &req,
                            std_srvs::Trigger::Response &res) {
            res.success = hasConverged();
            return true;
        }
        
    public:

        TrajectoryPredictor(ros::NodeHandle *nh) {
            object_position_subscriber = nh->subscribe("object_pos", 1, &TrajectoryPredictor::position_callback, this);
            reset_subscriber = nh->subscribe("reset", 1, &TrajectoryPredictor::reset_callback, this);    

            prediction_ready_service = nh->advertiseService("prediction_ready", &TrajectoryPredictor::readyToPredict, this);
            predict_position_service = nh->advertiseService("predict_position", &TrajectoryPredictor::predictPosition, this);
            observation_service = nh->advertiseService("observe_trajectory", &TrajectoryPredictor::observe, this);
            if(ros::param::has("detection_parameters/acceleration")) {
                ros::param::get("detection_parameters/acceleration/x", a[0]);
                ros::param::get("detection_parameters/acceleration/y", a[1]);
                ros::param::get("detection_parameters/acceleration/z", a[2]);
            } else {
                ROS_ERROR("Parameters not set!");
            }
        }

        bool ready_to_init() {
            return start_kalman_flag and positions_available();
        }

        bool positions_available() {
            return position_buffer.size() > 0;
        }

        void start_kalman() {
            start_kalman_flag = false;
            Vector3f z_0 = position_buffer.back();
            position_buffer.pop_back();

            float delta_time = (ros::Time::now() - previous_time).toSec();
            Vector3f v_0 = (z_0 - initial_position) / delta_time;
            ROS_INFO("init: x: %f, y: %f, z: %f", initial_position[0], initial_position[1], initial_position[2]);
            ROS_INFO("z_0: x: %f, y: %f, z: %f", z_0[0], z_0[1], z_0[2]);
            ROS_INFO("d_time: %f", delta_time);
            ROS_INFO("v_0 x: %f, y: %f, z: %f", v_0[0], v_0[1], v_0[2]);

            float u_0;
            float sigma_me;
            float sigma_a;

            if(ros::param::has("detection_parameters/u_0")) {
                ros::param::get("detection_parameters/u_0", u_0);
                ros::param::get("detection_parameters/sigma_me", sigma_me);
                ros::param::get("detection_parameters/sigma_a", sigma_a);
                ros::param::get("detection_parameters/sufficient_convergence", sufficient_convergence);
            }
            else {
                ROS_ERROR("Parameters not set!");
            }
            delete kf;
            kf = new KalmanFilter(z_0, v_0, u_0, sigma_me, sigma_a);
            kalman_initialized++;
        }

        void update_position() {
            Vector3f z = position_buffer.back();
            position_buffer.pop_back();
            ROS_DEBUG("x: %f, y: %f, z: %f", z[0], z[1], z[2]);

            float delta_time = (ros::Time::now() - previous_time).toSec();
            previous_time = ros::Time::now();


            Vector3f kpos = kf->current_position();
            Vector3f kvel = kf->current_velocity();
            kf->update(z, a, delta_time);

            kpos = kf->current_position();
            kvel = kf->current_velocity();
            ROS_DEBUG("Kx: %f, Ky: %f, Kz: %f, kdx: %f, kdy: %f, kdz: %f", kpos[0], kpos[1], kpos[2], kvel[0], kvel[1], kvel[2]);  

            float dist = eigen_dist(z, kpos);
            ROS_DEBUG("Dist: %f", dist);          
            accuracy.push_back(dist);
            if (accuracy.size() > NUM_ACCURACY_MEASUREMENTS) {
                accuracy.erase(accuracy.begin());
            }

            if (!ready) {
                if (hasConverged()) {
                    float time_to_ready = (ros::Time::now() - initial_time).toSec();
                    ROS_INFO("------------ Ready in %f seconds with dist %f -----------", time_to_ready, dist);
                    ready = true;
                }
            }
        }

};

int main(int argc, char** argv)
{
    ros::init(argc, argv, "trajectory_predictor");
    ros::NodeHandle nh;
    TrajectoryPredictor predictor = TrajectoryPredictor(&nh);

    ros::Rate rate(200);

    while (ros::ok()) {
        ros::spinOnce();
        if (predictor.ready_to_init()) {
            predictor.start_kalman();
        } 
        else if (predictor.positions_available()) {
            predictor.update_position();
        }
        rate.sleep();
    }

    ros::waitForShutdown();
}