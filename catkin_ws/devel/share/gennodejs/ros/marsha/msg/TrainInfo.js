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

class TrainInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.loss = null;
    }
    else {
      if (initObj.hasOwnProperty('loss')) {
        this.loss = initObj.loss
      }
      else {
        this.loss = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrainInfo
    // Serialize message field [loss]
    bufferOffset = _serializer.float32(obj.loss, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrainInfo
    let len;
    let data = new TrainInfo(null);
    // Deserialize message field [loss]
    data.loss = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marsha/TrainInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0243a756440bd40111a2b7951b9a568e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 loss
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TrainInfo(null);
    if (msg.loss !== undefined) {
      resolved.loss = msg.loss;
    }
    else {
      resolved.loss = 0.0
    }

    return resolved;
    }
};

module.exports = TrainInfo;
