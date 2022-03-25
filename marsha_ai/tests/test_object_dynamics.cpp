#include <ros/ros.h>
#include "marsha_ai/object_dynamics.h"

int main(int argc, char** argv)
{

  // linear test
  /*
  Vector3f x_0(1, 0, 0);
  Vector3f v_0(1, 0, 0);
  Vector3f a(0, 0, 0);
  */

  // Imaginary roots test
  /*
  Vector3f x_0(0, 1, 0);
  Vector3f v_0(0, 1, 0);
  Vector3f a(0, 1, 0);
  */

  // Real roots test
  /*
  Vector3f x_0(0, -1, 0);
  Vector3f v_0(0, 1, 0);
  Vector3f a(0, 1, 0);
  */

  // Test 5
  Vector3f x_0(-1, 0, 0);
  Vector3f v_0(1, 0, 1);
  Vector3f a(0, 0, -10);
  

  Approximator approx(x_0, v_0, a);

  double t = approx.solve();

  ROS_INFO("time: %f", t);

}