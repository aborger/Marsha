// Auto-generated. Do not edit!

// (in-package gazebo_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class SensorPerformanceMetric {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.sim_update_rate = null;
      this.real_update_rate = null;
      this.fps = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('sim_update_rate')) {
        this.sim_update_rate = initObj.sim_update_rate
      }
      else {
        this.sim_update_rate = 0.0;
      }
      if (initObj.hasOwnProperty('real_update_rate')) {
        this.real_update_rate = initObj.real_update_rate
      }
      else {
        this.real_update_rate = 0.0;
      }
      if (initObj.hasOwnProperty('fps')) {
        this.fps = initObj.fps
      }
      else {
        this.fps = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SensorPerformanceMetric
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [sim_update_rate]
    bufferOffset = _serializer.float64(obj.sim_update_rate, buffer, bufferOffset);
    // Serialize message field [real_update_rate]
    bufferOffset = _serializer.float64(obj.real_update_rate, buffer, bufferOffset);
    // Serialize message field [fps]
    bufferOffset = _serializer.float64(obj.fps, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SensorPerformanceMetric
    let len;
    let data = new SensorPerformanceMetric(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [sim_update_rate]
    data.sim_update_rate = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [real_update_rate]
    data.real_update_rate = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [fps]
    data.fps = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.name.length;
    return length + 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gazebo_msgs/SensorPerformanceMetric';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '01762ded18cfe9ebc7c8222667c99547';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new SensorPerformanceMetric(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.sim_update_rate !== undefined) {
      resolved.sim_update_rate = msg.sim_update_rate;
    }
    else {
      resolved.sim_update_rate = 0.0
    }

    if (msg.real_update_rate !== undefined) {
      resolved.real_update_rate = msg.real_update_rate;
    }
    else {
      resolved.real_update_rate = 0.0
    }

    if (msg.fps !== undefined) {
      resolved.fps = msg.fps;
    }
    else {
      resolved.fps = 0.0
    }

    return resolved;
    }
};

module.exports = SensorPerformanceMetric;
