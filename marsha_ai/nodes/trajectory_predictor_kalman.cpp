/*

* Calculates velocity of object given positions

*/

#include <ros/ros.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Vector3.h>

#include <std_msgs/Empty.h>

#include <tf/tf.h>
#include <Eigen/Dense>
#include <cmath>

#include "marsha_msgs/PredictPosition.h"
#include "marsha_msgs/ObjectObservation.h"


#define REACH    0.3

typedef Eigen::Matrix<float, 3, 3> Matrix3f;
typedef Eigen::Matrix<float, 6, 6> Matrix6f;
typedef Eigen::Matrix<float, 3, 1> Vector3f;
typedef Eigen::Matrix<float, 6, 1> Vector6f;

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

void print_mat6(const Matrix6f m) {
    ROS_INFO("----------------------");
    for (int r = 0; r < 6; r++) {
        ROS_INFO("%f %f %f %f %f %f", m(r, 0), m(r, 1), m(r, 2), m(r, 3), m(r, 4), m(r, 5));
    }
    ROS_INFO("----------------------");
}

void print_mat3_6(const Eigen::Matrix<float, 3, 6> m) {
    ROS_INFO("----------------------");
    for (int r = 0; r < 3; r++) {
        ROS_INFO("%f %f %f %f %f %f", m(r, 0), m(r, 1), m(r, 2), m(r, 3), m(r, 4), m(r, 5));
    }
    ROS_INFO("----------------------");
}

void print_mat6_3(const Eigen::Matrix<float, 6, 3> m) {
    ROS_INFO("----------------------");
    for (int r = 0; r < 6; r++) {
        ROS_INFO("%f %f %f", m(r, 0), m(r, 1), m(r, 2));
    }
    ROS_INFO("----------------------");
}

void print_V6f(const std::string name, const Vector6f vect) {
    
}

float eigen_dist(Vector3f vectA, Vector3f vectB) {
    Vector3f diff = vectA - vectB;
    return sqrt(pow(diff[0], 2) + pow(diff[1], 2) + pow(diff[2], 2));
}

// Based off the multidimensional kalman filter explanation at:
// https://www.kalmanfilter.net/stateextrap.html
class KalmanFilter {
    private:
        Vector6f x; // State estimate vector (x, y, z, dx, dy, dz)

        bool position_initialized = false;
        bool velocity_initialized = false; 
        Matrix6f P; // Uncertainty/covariance estimate matrix

        Eigen::Matrix<float, 6, 3> K; // Kalman gain
        Eigen::Matrix<float, 3, 6> H; // Observation matrix

        // Uncertainty constants
        Matrix3f R; // R = Measurement Uncertainty (Measurement noise covariance matrix)
        float sigma_a2; // Process noise variance of control input, Sigma_a^2 (Acceleration variance)
    public:
        // z_0 = Initial state (x, y, z), for marsha ball throw this should be the instant it leaves the throw gripper
        // v0_estimate = Initial velocity estimate (dx, dy, dz), 1 in/sec for marsha ball throw
        // u = control vector (measured acceleration)
        // uncertainty_estimate = An initial estimate at how certain the measurement is. (Initial measurement should be good as the initial state is throwing arm end effector position)
        // sigma_me = position measurement error standard deviation
        // sigma_a = random acceleration standard deviation
        KalmanFilter(const Vector3f z_0, const Vector3f v0_estimate, const Vector3f u, float uncertainty_estimate, float sigma_me, float sigma_a) {
            // Initialize estimates
            x.topLeftCorner(3, 1) = z_0;
            x.bottomLeftCorner(3, 1) = v0_estimate;

            // Calculate constants
            R = Matrix3f::Identity() * sigma_me * sigma_me;
            sigma_a2 = sigma_a * sigma_a;

            P = Matrix6f::Zero(); // Can we initialize it to something better?
            
            H = Eigen::MatrixXf::Zero(3, 6);
            H.bottomLeftCorner(3, 3) = Matrix3f::Identity();
        }

        KalmanFilter() {}

        // Predict next state (x) and uncertainty (p) with
        // x_c = current state estimation
        // u = control vector (measured acceleration)
        // dt = change in time
        // p_c = current uncertainty estimate
        // Follows equation: x = x0 + dx*dt + dx*dt*dt
        void predict(Vector6f x_c, Vector3f u, float dt) {
            // Calculate state transition matrix
            Matrix6f F = Matrix6f::Identity();
            F.topRightCorner(3, 3) = Matrix3f::Identity() * dt;

            // Calculate control matrix
            Eigen::Matrix<float, 6, 3> G = Eigen::MatrixXf::Zero(6, 3);
            G.bottomLeftCorner(3, 3) = Matrix3f::Identity() * dt;
            G.topRightCorner(3, 3) = Matrix3f::Identity() * 0.5 * dt * dt;

            // Predict next state vector x
            x = F*x_c + G*u;

            // Predict next uncertainty/covariance matrix
            Matrix6f Q = sigma_a2 * G * G.transpose();
            P = P * F * F.transpose() + Q;



        }

        // z = measured system state
        // u = control vector (measured acceleration)
        // dt = change in time
        void update(Vector3f z, Vector3f u, float dt) {
            // Update kalman gain
            Matrix3f A = H * P * H.transpose() + R; // A is just a name, it doesn't represent anything
            K = P * H.transpose() * A.inverse();

            // Update uncertainty / covariance estimate
            Matrix6f I_KH = Matrix6f::Identity() - K * H;
            P = I_KH * P * I_KH.transpose() + K * R * K.transpose();

            // Update current state estimate
            Vector6f x_c = x + K * (z - H*x);
            predict(x_c, u, dt);
        }

        Vector3f current_position() {
            Vector3f pos = Vector3f(x[0], x[1], x[2]);
            return pos;
        }

        Vector3f current_velocity() {
            Vector3f vel = Vector3f(x[3], x[4], x[5]);
            return vel;
        }
};


class TrajectoryPredictor {
    private:
        ros::Subscriber object_position_subscriber;
        ros::Subscriber reset_subscriber;

        ros::ServiceServer predict_position_service;
        ros::ServiceServer observation_service;

        KalmanFilter* kf = new KalmanFilter();

        unsigned char kalman_initialized = 0;
        Vector3f initial_position;

        ros::Time previous_time;

        Vector3f a;


        void reset_callback(const std_msgs::Empty::ConstPtr& msg) {
            kalman_initialized = 0;
            ROS_INFO("--- Reset ---");
        }

        void position_callback(const geometry_msgs::Point& msg) {
            // Two positions are used to initialize the kalman. This way the velocity can be estimated
            if (kalman_initialized < 2) {
                initial_position = msg_to_v3f(msg);
                previous_time = ros::Time::now();
                kalman_initialized++;
            }
            else if (kalman_initialized == 2) {
                Vector3f z_0 = msg_to_v3f(msg);
                float delta_time = (ros::Time::now() - previous_time).toSec();
                Vector3f v_0 = (z_0 - initial_position) / delta_time;
                ROS_INFO("init: x: %f, y: %f, z: %f", initial_position[0], initial_position[1], initial_position[2]);
                ROS_INFO("z_0: x: %f, y: %f, z: %f", z_0[0], z_0[1], z_0[2]);
                ROS_INFO("d_time: %f", delta_time);
                ROS_INFO("v_0 x: %f, y: %f, z: %f", v_0[0], v_0[1], v_0[2]);

                float u_0;
                float sigma_me;
                float sigma_a;

                ros::param::get("detection_parameters/u_0", u_0);
                ros::param::get("detection_parameters/sigma_me", sigma_me);
                ros::param::get("detection_parameters/sigma_a", sigma_a);
                delete kf;
                kf = new KalmanFilter(z_0, v_0, a, u_0, sigma_me, sigma_a);
                kalman_initialized++;
            }
            else {


                ROS_INFO("x: %f, y: %f, z: %f", msg.x, msg.y, msg.z);
                Vector3f z = Vector3f(msg.x, msg.y, msg.z);
                float delta_time = (ros::Time::now() - previous_time).toSec();
                previous_time = ros::Time::now();

                kf->update(z, a, delta_time);

                Vector3f kpos = kf->current_position();
                Vector3f kvel = kf->current_velocity();
                ROS_INFO("Kx: %f, Ky: %f, Kz: %f, kdx: %f, kdy: %f, kdz: %f", kpos[0], kpos[1], kpos[2], kvel[0], kvel[1], kvel[2]);  

                float dist = eigen_dist(z, kpos);
                ROS_INFO("Dist: %f", dist);          

            }
        }

        // Convert normtime on [0, 1] to ros::time where the object position at 0.5 norm time is closest to the arm.
        // Predict position with T(t) = v*t + x_0 (assuming no acceleration occurs)
        /*bool predictPosition(marsha_msgs::PredictPosition::Request &req,
                             marsha_msgs::PredictPosition::Response &res) 
        {
            tf::Vector3 base_position = tf::Vector3(0, 0, 0);
            // Calculate time closest to end effector
            ROS_INFO("-------------------");
            ROS_INFO("calculating t' base_position:");
            print_vect(base_position);
            tf::Vector3 velocity_dir = avg_velocity() / avg_velocity().length();
            float x_prime = velocity_dir.dot(base_position - initial_position) / (velocity_dir.dot(velocity_dir));

            // Calculate de-normalized version of normalized time (translate [0, 1] to ros::time)
            ROS_INFO("calculating de_norm: x_prime: %f, norm_dist: %f", x_prime, req.norm_dist);
            float delta_pos = 2*REACH*req.norm_dist + x_prime - REACH;
            ROS_INFO("delta pos: %f", delta_pos);

            // Calculate position of object along trajectory or de_norm time
            tf::Vector3 predicted_position = initial_position + delta_pos * velocity_dir;

            //ros::Duration delta_time = ros::Duration(predicted_position.distance(initial_position) / avg_velocity().length());
            // Fix long delay maybe:
            ros::Duration delta_time = ros::Duration(delta_pos / avg_velocity().length());

            ROS_INFO("predicted pos: x: %f y: %f z: %f", predicted_position.x(), predicted_position.y(), predicted_position.z());
            ROS_INFO("delta time: %f", delta_time.toSec());
            ROS_INFO("----------------------");

            // Convert tf vector3 to geometry_msgs Point
            geometry_msgs::Point position_msg;
            position_msg.x = predicted_position.x();
            position_msg.y = predicted_position.y();
            position_msg.z = predicted_position.z();
            res.position = position_msg;
            res.predicted_time.data = ros::Time(previous_time + delta_time);
            
            return true;
        }*/




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
        
    public:

        TrajectoryPredictor(ros::NodeHandle *nh) {
            object_position_subscriber = nh->subscribe("object_pos", 10, &TrajectoryPredictor::position_callback, this);
            reset_subscriber = nh->subscribe("reset", 1, &TrajectoryPredictor::reset_callback, this);    

            //predict_position_service = nh->advertiseService("predict_position", &TrajectoryPredictor::predictPositionKalman, this);
            observation_service = nh->advertiseService("observe_trajectory", &TrajectoryPredictor::observe, this);
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