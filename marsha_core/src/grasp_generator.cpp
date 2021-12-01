/*

* Generates a grasp around a sphere from polar coordinates on range (0, 0, 0) to (1, 2pi, 2pi)

* Replaces the variational auto encoder in the 6-DOF GraspNet paper.

* Statistically there is a uniform distribution of grasps around the spherical object.
*/


#include <ros/ros.h>


#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Quaternion.h>
#include <marsha_msgs/GenerateGrasp.h>


#include <math.h>

#include <tf/tf.h>


class GraspGenerator {
    private:
        float radius_min;
        float radius_max;
        ros::ServiceServer generateService;

        // Converts radius on interval [0, 1) to [radius_min, radius_max)
        float convert_radius(float normalized_radius) {
            //ROS_INFO("radius max: %f min: %f", radius_max, radius_min);
            return normalized_radius * (radius_max - radius_min) + radius_min;
        }

        // Note: r - [0, inf), theta - [0, pi], phi - [0, 2pi)
        // Should probably throw error if this occures
        geometry_msgs::Point polar_to_rect(float r, float theta, float phi) {
            geometry_msgs::Point position;
            position.x = r * sin(phi) * cos(theta);
            position.y = r * sin(phi) * sin(theta);
            position.z = r * cos(phi);
            return position;
        }

        void print_vect(tf::Vector3 vect) {
            ROS_INFO("Vector: x: %f y: %f z: %f", vect.x(), vect.y(), vect.z());
        }

        void print_quat(tf::Quaternion quat) {
            ROS_INFO("Quaternion: X: %f Y: %f Z: %f W: %f", quat.x(), quat.y(), quat.z(), quat.w());
        }

        geometry_msgs::Pose generate(float normalized_r, float theta, float phi) {
            geometry_msgs::Pose pose;
            float radius = convert_radius(normalized_r);
            ROS_INFO("----------------");
            ROS_INFO("Polar coords: r: %f, theta: %f, phi: %f", radius, theta, phi);
            pose.position = polar_to_rect(radius, theta, phi);
            ROS_INFO("Position: x: %f y: %f z: %f", pose.position.x, pose.position.y, pose.position.z);
            tf::Vector3 wrist_vector = tf::Vector3(pose.position.x, pose.position.y, pose.position.z);
            tf::Vector3 z = tf::Vector3(0, 0, 1);

            tf::Vector3 rot_axis = wrist_vector.cross(z);
            float rot_angle = asin(rot_axis.length() / (wrist_vector.length() * z.length()));

            print_vect(rot_axis.normalized());
            ROS_INFO("rotation angle: %f", rot_angle);

            
            tf::Quaternion orientation = tf::Quaternion(rot_axis.normalized(), -1*rot_angle-M_PI);
            
            print_quat(orientation.normalize());

            pose.orientation.x = orientation.x();
            pose.orientation.y = orientation.y();
            pose.orientation.z = orientation.z();
            pose.orientation.w = orientation.w();

            return pose;
        }

    public:

        GraspGenerator(ros::NodeHandle *nh, float object_radius, float gripper_length) {
            radius_min = object_radius;
            radius_max = gripper_length;

            generateService = nh->advertiseService("generate_grasp", &GraspGenerator::generate_grasp, this);
        }

        bool generate_grasp(marsha_msgs::GenerateGrasp::Request &req,
                            marsha_msgs::GenerateGrasp::Response &res) 
        {
            //ROS_INFO("r: %f theta: %f phi %f", req.radius, req.theta, req.phi);
            res.grasp = generate(req.radius, req.theta, req.phi);
            //ROS_INFO("z: %f", res.grasp.position.z);
            return true;
        }


        



};

int main(int argc, char** argv)
{
    ros::init(argc, argv, "grasp_generator");
    ros::NodeHandle nh;
    ros::AsyncSpinner spinner(4);
    spinner.start();
    GraspGenerator generator = GraspGenerator(&nh, 0.03, 0.1);
    ros::waitForShutdown();
}