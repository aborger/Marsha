
#include <Eigen/Dense>
#include <ros/ros.h>

typedef Eigen::Matrix<float, 3, 3> Matrix3f;
typedef Eigen::Matrix<float, 6, 6> Matrix6f;
typedef Eigen::Matrix<float, 3, 1> Vector3f;
typedef Eigen::Matrix<float, 6, 1> Vector6f;

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
// Based off the multidimensional kalman filter explanation at:
// https://www.kalmanfilter.net/stateextrap.758.23291015625html
class KalmanFilter {
    const float acceptable_convergence = 1.0;
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
        KalmanFilter(Vector3f z_0, Vector3f v0_estimate, float uncertainty_estimate, float sigma_me, float sigma_a) {
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


        tf::Vector3 tf_current_position() {
            return tf::Vector3(x[0], x[1], x[2]);
        }

        tf::Vector3 tf_current_velocity() {
            return tf::Vector3(x[3], x[4], x[5]);
        }

};