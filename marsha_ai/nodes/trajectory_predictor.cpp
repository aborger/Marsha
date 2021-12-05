/*

* Calculates velocity of object given positions

*/

#include <ros/ros.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Vector3.h>

#include <std_msgs/Empty.h>

#include <tf/tf.h>

#include "marsha_msgs/PredictPosition.h"
#include "marsha_msgs/ObjectObservation.h"

#define REACH    0.3


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


class TrajectoryPredictor {
    private:
        ros::Subscriber object_position_subscriber;
        ros::Subscriber reset_subscriber;

        ros::ServiceServer predict_position_service;
        ros::ServiceServer observation_service;

        tf::Vector3 initial_position;
        tf::Vector3 prev_position;
        tf::Vector3 velocity_sum;
        int num_velocities;

        ros::Time initial_time;
        bool position_initialized = false;
        bool velocity_initialized = false;

        tf::Vector3 avg_velocity() {
            return velocity_sum / num_velocities;
        }

        void reset_callback(const std_msgs::Empty::ConstPtr& msg) {
            position_initialized = false;

            velocity_sum = tf::Vector3(0, 0, 0);
            num_velocities = 0;

            ROS_INFO("--- Reset ---");
        }

        void position_callback(const geometry_msgs::Pose::ConstPtr& msg) {
            tf::Vector3 current_velocity;
            if (!position_initialized) {
                initial_position = msg_to_vector(msg->position);
                prev_position = initial_position;
                initial_time = ros::Time::now();
                position_initialized = true;

            } else {
                tf::Vector3 current_position = msg_to_vector(msg->position);

                ros::Duration delta_time = ros::Time::now() - initial_time;

                current_velocity = (current_position - prev_position) / delta_time.toSec();
                ROS_INFO("Current velocity:");
                print_vect(current_velocity);

                velocity_sum += current_velocity;
                num_velocities ++;

                //ROS_INFO("Avg veloctity:");
                //print_vect(avg_velocity());


                
            }

        }

        // Convert normtime on [0, 1] to ros::time where the object position at 0.5 norm time is closest to the arm.
        // Predict position with T(t) = v*t + x_0 (assuming no acceleration occurs)
        bool predictPosition(marsha_msgs::PredictPosition::Request &req,
                             marsha_msgs::PredictPosition::Response &res) 
        {
            tf::Vector3 base_position = tf::Vector3(0, 0, 0);
            // Calculate time closest to end effector
            ROS_INFO("-------------------");
            ROS_INFO("calculating t' base_position:");
            print_vect(base_position);
            ROS_INFO("initial position:");
            print_vect(initial_position);
            ROS_INFO("average velocity:");
            print_vect(avg_velocity());
            tf::Vector3 velocity_dir = avg_velocity() / avg_velocity().length();
            float x_prime = velocity_dir.dot(base_position - initial_position) / (velocity_dir.dot(velocity_dir));

            // Calculate de-normalized version of normalized time (translate [0, 1] to ros::time)
            ROS_INFO("calculating de_norm: x_prime: %f, norm_dist: %f", x_prime, req.norm_dist);
            float delta_pos = 2*REACH*req.norm_dist + x_prime - REACH;
            ROS_INFO("delta pos: %f", delta_pos);

            // Calculate position of object along trajectory or de_norm time
            tf::Vector3 predicted_position = initial_position + delta_pos * velocity_dir;

            ros::Duration delta_time = ros::Duration(predicted_position.distance(initial_position) / avg_velocity().length());

            ROS_INFO("predictied pos: x: %f y: %f z: %f", predicted_position.x(), predicted_position.y(), predicted_position.z());
            ROS_INFO("delta time: %f", delta_time.toSec());
            ROS_INFO("----------------------");

            // Convert tf vector3 to geometry_msgs Point
            geometry_msgs::Point position_msg;
            position_msg.x = predicted_position.x();
            position_msg.y = predicted_position.y();
            position_msg.z = predicted_position.z();
            res.position = position_msg;
            res.predicted_time.data = ros::Time(initial_time + delta_time);
            
            return true;
        }

        bool observe(marsha_msgs::ObjectObservation::Request &req,
                     marsha_msgs::ObjectObservation::Response &res) {

            res.initial_position = vector_to_Pmsg(initial_position);
            res.velocity = vector_to_Vmsg(avg_velocity());
            return true;
        }
        
    public:

        TrajectoryPredictor(ros::NodeHandle *nh) {
            object_position_subscriber = nh->subscribe("object_pos", 10, &TrajectoryPredictor::position_callback, this);
            reset_subscriber = nh->subscribe("reset", 1, &TrajectoryPredictor::reset_callback, this);    

            predict_position_service = nh->advertiseService("predict_position", &TrajectoryPredictor::predictPosition, this);
            observation_service = nh->advertiseService("observe", &TrajectoryPredictor::observe, this);
        }

};

int main(int argc, char** argv)
{
    ros::init(argc, argv, "trajectory_predictor");
    ros::NodeHandle nh;
    ros::AsyncSpinner spinner(4);
    spinner.start();
    TrajectoryPredictor predictor = TrajectoryPredictor(&nh);
    ros::waitForShutdown();
}