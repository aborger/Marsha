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

class RosUnitySrvMessage {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.srv_id = null;
      this.is_request = null;
      this.topic = null;
      this.payload = null;
    }
    else {
      if (initObj.hasOwnProperty('srv_id')) {
        this.srv_id = initObj.srv_id
      }
      else {
        this.srv_id = 0;
      }
      if (initObj.hasOwnProperty('is_request')) {
        this.is_request = initObj.is_request
      }
      else {
        this.is_request = false;
      }
      if (initObj.hasOwnProperty('topic')) {
        this.topic = initObj.topic
      }
      else {
        this.topic = '';
      }
      if (initObj.hasOwnProperty('payload')) {
        this.payload = initObj.payload
      }
      else {
        this.payload = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RosUnitySrvMessage
    // Serialize message field [srv_id]
    bufferOffset = _serializer.int32(obj.srv_id, buffer, bufferOffset);
    // Serialize message field [is_request]
    bufferOffset = _serializer.bool(obj.is_request, buffer, bufferOffset);
    // Serialize message field [topic]
    bufferOffset = _serializer.string(obj.topic, buffer, bufferOffset);
    // Serialize message field [payload]
    bufferOffset = _arraySerializer.uint8(obj.payload, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RosUnitySrvMessage
    let len;
    let data = new RosUnitySrvMessage(null);
    // Deserialize message field [srv_id]
    data.srv_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [is_request]
    data.is_request = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [topic]
    data.topic = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [payload]
    data.payload = _arrayDeserializer.uint8(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.topic.length;
    length += object.payload.length;
    return length + 13;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ros_tcp_endpoint/RosUnitySrvMessage';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5e4da90c1cd45db0881a77473482b38e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 srv_id
    bool is_request
    string topic
    uint8[] payload
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RosUnitySrvMessage(null);
    if (msg.srv_id !== undefined) {
      resolved.srv_id = msg.srv_id;
    }
    else {
      resolved.srv_id = 0
    }

    if (msg.is_request !== undefined) {
      resolved.is_request = msg.is_request;
    }
    else {
      resolved.is_request = false
    }

    if (msg.topic !== undefined) {
      resolved.topic = msg.topic;
    }
    else {
      resolved.topic = ''
    }

    if (msg.payload !== undefined) {
      resolved.payload = msg.payload;
    }
    else {
      resolved.payload = []
    }

    return resolved;
    }
};

module.exports = RosUnitySrvMessage;
