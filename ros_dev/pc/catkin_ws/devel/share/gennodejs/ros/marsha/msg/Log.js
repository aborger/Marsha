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

class Log {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.logLevel = null;
      this.msg = null;
    }
    else {
      if (initObj.hasOwnProperty('logLevel')) {
        this.logLevel = initObj.logLevel
      }
      else {
        this.logLevel = 0;
      }
      if (initObj.hasOwnProperty('msg')) {
        this.msg = initObj.msg
      }
      else {
        this.msg = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Log
    // Serialize message field [logLevel]
    bufferOffset = _serializer.int32(obj.logLevel, buffer, bufferOffset);
    // Serialize message field [msg]
    bufferOffset = _serializer.string(obj.msg, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Log
    let len;
    let data = new Log(null);
    // Deserialize message field [logLevel]
    data.logLevel = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [msg]
    data.msg = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.msg.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marsha/Log';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '342fa202d332a78f4d751b1a33e13a8f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 logLevel
    string msg
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Log(null);
    if (msg.logLevel !== undefined) {
      resolved.logLevel = msg.logLevel;
    }
    else {
      resolved.logLevel = 0
    }

    if (msg.msg !== undefined) {
      resolved.msg = msg.msg;
    }
    else {
      resolved.msg = ''
    }

    return resolved;
    }
};

module.exports = Log;
