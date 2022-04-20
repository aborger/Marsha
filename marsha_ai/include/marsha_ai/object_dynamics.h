#include <Eigen/Dense>
#include <ros/ros.h>


#define EPSILON 0.01 // sufficient convergence


typedef Eigen::Matrix<float, 3, 1> Vector3f;



Vector3f mult(Vector3f vect1, Vector3f vect2) {
    return Vector3f(vect1[0] * vect2[0], vect1[1] * vect2[1], vect1[2] * vect2[2]);
}

float eigen_dist(Vector3f vectA, Vector3f vectB) {
    Vector3f diff = vectA - vectB;
    return sqrt(pow(diff[0], 2) + pow(diff[1], 2) + pow(diff[2], 2));
}

// x_0: Initial position vector
// v_0: Initial velocity vector
// a:   Acceleration vector
// Returns float of the time until the closest position
// Approximates time when ball is closest to the base of the robot
// Approximates using the Newton-Raphson method
// Note: time is a float representing the number of seconds after the last position measurement was taken.
class Approximator {
    private:
        double b;
        double c;
        double d;
        double e;
        double f;

        bool is_linear = false;
        double initial_guess;


        // derivative of the distance between ball and base with respect to time
        // calculates the approximate roots to this equation
        // when t = 0, the distance is either at a maximum or minimum
        double func(double t) {
            double func_return = 4*f*t*t*t + 3*e*t*t + 2*(c+d)*t + b;
            ROS_INFO("func return: %f", func_return);
            return func_return;
        }

        // double derivate
        double derivFunc(double t) {
            double deriv_return = 12*f*t*t + 6*e*t + 2*(c+d);
            ROS_INFO("derive return: %f", deriv_return);
            return deriv_return;
        }

        // Parameter t: Initial guess at the closest time
        // Iteratively calculates more accurate times until close enough as defined by EPSILON
        double newtonRaphson(double t) {
            double h = func(t) / derivFunc(t);

            ROS_INFO("Beginning loop with initial h: %f", h);
            while (abs(h) >= EPSILON) {
                h = func(t)/derivFunc(t);
                ROS_INFO("h: %f", h);

                t = t - h;
                ROS_INFO("t: %f", t);
            }
            return t;
        }

        double linear() {
            return (-1 * b) / (2 * d);
        }

    public:
        // x_0: Initial position vector
        // v_0: Initial velocity vector
        // a:   Acceleration vector
        // t_0: Optional initial guess at time
        // Returns float of the time until the closest position
        Approximator(Vector3f _x_0, Vector3f _v_0, Vector3f _a, double t_0=1.0) {
            b = 2*_x_0.sum() * _v_0.sum();
            c = _x_0.sum() * _a.sum();
            d = mult(_v_0, _v_0).sum();
            e = _v_0.sum() * _a.sum();
            f = 0.25 * mult(_a, _a).sum();

            ROS_INFO("b: %f", b);
            ROS_INFO("c: %f", c);
            ROS_INFO("d: %f", d);
            ROS_INFO("e: %f", e);
            ROS_INFO("f: %f", f);

            // Use different solving method if there is no acceleration
            if (_a.sum() == 0) {
                is_linear = true;
            }

        }

        virtual double solve() {
            if (is_linear) {
                return linear();
            } else {
                return newtonRaphson(1);
            }
        }

};


class Searcher {
    private:
        Vector3f x_0;
        Vector3f v_0;
        Vector3f a;

        float t_0;

        float b;
        float d;

        bool is_linear = false;

        float linear() {
            return (-1 * b) / (2 * d);
        }

        float distance(float t) {
            Vector3f obj_pos = x_0 + v_0*t + 0.5*a*t*t;
            ROS_INFO("position: [x: %f, y: %f, z: %f]", obj_pos[0], obj_pos[1], obj_pos[2]);
            Vector3f robot_base(0.24, 0, 0);
            return eigen_dist(robot_base, obj_pos);
        }

        float binarySearch(float before, float after) {

            float mid = before + (after - before) / 2;
            ROS_INFO("search [before: %f, mid: %f, after %f]", before, mid, after);
            float mid_dist = distance(mid);
            float after_dist = distance(after);
            float before_dist = distance(before);

            ROS_INFO("dist: [before: %f, mid: %f, after: %f]", before_dist, mid_dist, after_dist);
            // if not much change occurs local minimum has been reached
            if (abs(after_dist - before_dist) < EPSILON) {
                return mid;
            }

            if (mid_dist < before_dist and mid_dist < after_dist) {
                if (before_dist < after_dist) {
                    return binarySearch(before, mid);
                }
                else {
                    return binarySearch(mid, after);
                }
            }

            // mid_dist is also less than before_dist
            if (mid_dist > after_dist) {
                return binarySearch(mid, after);
            }
            
            if (mid_dist > before_dist) {
                return binarySearch(before, mid);
            }

            throw;
                

                
            
        }
    public:
        Searcher(Vector3f _x_0, Vector3f _v_0, Vector3f _a, float _t_0=200.0) {
            b = 2*_x_0.sum() * _v_0.sum();
            d = mult(_v_0, _v_0).sum();

            x_0 = _x_0;
            v_0 = _v_0;
            a = _a;
            t_0 = _t_0;

            ROS_INFO("x_0: [x: %f, y: %f, z: %f]", x_0[0], x_0[1], x_0[2]);
            ROS_INFO("v_0: [x: %f, y: %f, z: %f]", v_0[0], v_0[1], v_0[2]);
            ROS_INFO("a:   [x: %f, y: %f, z: %f]", a[0], a[1], a[2]);

            // Use different solving method if there is no acceleration
            if (_a.sum() == 0) {
                is_linear = true;
            }
        }

        float solve() {
            ROS_INFO("Solving...");
            if (is_linear) {
                return linear();
            } else {
                return binarySearch(0, t_0);
            }
        }
};