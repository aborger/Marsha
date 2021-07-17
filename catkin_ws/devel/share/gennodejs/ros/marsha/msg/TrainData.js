// Auto-generated. Do not edit!

// (in-package marsha.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class TrainData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.targets = null;
    }
    else {
      if (initObj.hasOwnProperty('targets')) {
        this.targets = initObj.targets
      }
      else {
        this.targets = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrainData
    // Serialize message field [targets]
    bufferOffset = _arraySerializer.float32(obj.targets, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrainData
    let len;
    let data = new TrainData(null);
    // Deserialize message field [targets]
    data.targets = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.targets.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marsha/TrainData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'aa3cd371077e3b3151f9319b3ebdff23';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32[] targets
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TrainData(null);
    if (msg.targets !== undefined) {
      resolved.targets = msg.targets;
    }
    else {
      resolved.targets = []
    }

    return resolved;
    }
};

module.exports = TrainData;
