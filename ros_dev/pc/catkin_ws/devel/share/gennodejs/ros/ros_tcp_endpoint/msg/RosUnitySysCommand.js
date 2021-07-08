// Auto-generated. Do not edit!

// (in-package ros_tcp_endpoint.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class RosUnitySysCommand {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.command = null;
      this.params_json = null;
    }
    else {
      if (initObj.hasOwnProperty('command')) {
        this.command = initObj.command
      }
      else {
        this.command = '';
      }
      if (initObj.hasOwnProperty('params_json')) {
        this.params_json = initObj.params_json
      }
      else {
        this.params_json = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RosUnitySysCommand
    // Serialize message field [command]
    bufferOffset = _serializer.string(obj.command, buffer, bufferOffset);
    // Serialize message field [params_json]
    bufferOffset = _serializer.string(obj.params_json, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RosUnitySysCommand
    let len;
    let data = new RosUnitySysCommand(null);
    // Deserialize message field [command]
    data.command = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [params_json]
    data.params_json = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.command.length;
    length += object.params_json.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ros_tcp_endpoint/RosUnitySysCommand';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '136891578342d9ff1f4f30a7e0d8ddac';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string command
    string params_json
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RosUnitySysCommand(null);
    if (msg.command !== undefined) {
      resolved.command = msg.command;
    }
    else {
      resolved.command = ''
    }

    if (msg.params_json !== undefined) {
      resolved.params_json = msg.params_json;
    }
    else {
      resolved.params_json = ''
    }

    return resolved;
    }
};

module.exports = RosUnitySysCommand;
