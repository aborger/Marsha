// Auto-generated. Do not edit!

// (in-package gazebo_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let SensorPerformanceMetric = require('./SensorPerformanceMetric.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class PerformanceMetrics {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.real_time_factor = null;
      this.sensors = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('real_time_factor')) {
        this.real_time_factor = initObj.real_time_factor
      }
      else {
        this.real_time_factor = 0.0;
      }
      if (initObj.hasOwnProperty('sensors')) {
        this.sensors = initObj.sensors
      }
      else {
        this.sensors = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PerformanceMetrics
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [real_time_factor]
    bufferOffset = _serializer.float64(obj.real_time_factor, buffer, bufferOffset);
    // Serialize message field [sensors]
    // Serialize the length for message field [sensors]
    bufferOffset = _serializer.uint32(obj.sensors.length, buffer, bufferOffset);
    obj.sensors.forEach((val) => {
      bufferOffset = SensorPerformanceMetric.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PerformanceMetrics
    let len;
    let data = new PerformanceMetrics(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [real_time_factor]
    data.real_time_factor = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [sensors]
    // Deserialize array length for message field [sensors]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.sensors = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.sensors[i] = SensorPerformanceMetric.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.sensors.forEach((val) => {
      length += SensorPerformanceMetric.getMessageSize(val);
    });
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gazebo_msgs/PerformanceMetrics';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '884f71fd5037b886ec5e126b83c4425a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float64 real_time_factor
    gazebo_msgs/SensorPerformanceMetric[] sensors
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: gazebo_msgs/SensorPerformanceMetric
    string name
    float64 sim_update_rate
    float64 real_update_rate
    float64 fps
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PerformanceMetrics(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.real_time_factor !== undefined) {
      resolved.real_time_factor = msg.real_time_factor;
    }
    else {
      resolved.real_time_factor = 0.0
    }

    if (msg.sensors !== undefined) {
      resolved.sensors = new Array(msg.sensors.length);
      for (let i = 0; i < resolved.sensors.length; ++i) {
        resolved.sensors[i] = SensorPerformanceMetric.Resolve(msg.sensors[i]);
      }
    }
    else {
      resolved.sensors = []
    }

    return resolved;
    }
};

module.exports = PerformanceMetrics;
