/*

* Generates a grasp around a sphere from polar coordinates on range (0, 0, 0) to (1, 2pi, 2pi)

* Replaces the variational auto encoder in the 6-DOF GraspNet paper.

* Statistically there is a uniform distribution of grasps around the spherical object.
*/


#include <ros/ros.h>


#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Point.h>
#include <marsha_msgs/GenerateGrasp.h>

#include <math.h>


class GraspGenerator {
    private:
        float radius_min;
        float radius_max;
        ros::ServiceServer generateService;

        // Converts radius on interval [0, 1) to [radius_min, radius_max)
        float convert_radius(float normalized_radius) {
            return normalized_radius * (radius_max - radius_min) + radius_min;
        }

        geometry_msgs::Point polar_to_rect(float r, float theta, float phi) {
            geometry_msgs::Point position;
            position.x = r * sin(phi) * cos(theta);
            position.y = r * sin(phi) * sin(phi);
            position.z = r * cos(phi);
            return position;
        }

        geometry_msgs::Pose generate(float r, float theta, float phi) {
            geometry_msgs::Pose pose;
            pose.position = polar_to_rect(r, theta, phi);
            return pose;
        }

    public:

        GraspGenerator(ros::NodeHandle *nh, float object_radius, float gripper_length) {
            float radius_min = object_radius;
            float radius_max = gripper_length;

            generateService = nh->advertiseService("generate_grasp", &GraspGenerator::generate_grasp, this);
        }

        bool generate_grasp(marsha_msgs::GenerateGrasp::Request &req,
                            marsha_msgs::GenerateGrasp::Response &res) 
        {
            res.grasp = generate(req.latent_space.radius, req.latent_space.theta, req.latent_space.phi);
            return true;
        }


        



};

int main(int argc, char** argv)
{
    ros::init(argc, argv, "grasp_generator");
    ros::NodeHandle nh;
    ros::AsyncSpinner spinner(4);
    spinner.start();
    GraspGenerator generator = GraspGenerator(&nh, 0.03, .05);
    ros::waitForShutdown();
}