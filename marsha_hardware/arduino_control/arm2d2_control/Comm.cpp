#include "Comm.h"


/* ============================================== */
/*                       RxPacket                 */
/* ============================================== */

// Note: no protection if transmitted steps have a different number of joints
RxPacket::RxPacket() {
  step_cmd = new int [DEFAULT_PACKET_SIZE];
}

// Construct from json
// Apparently you cant pass a JsonDocument?
/*RxPacket::RxPacket(const JsonDocument &doc) {
  led_state = doc["led"];
}*/

RxPacket::~RxPacket() {
  delete(step_cmd);
}



/* ============================================== */
/*                     TxPacket                   */
/* ============================================== */

TxPacket::TxPacket(int _num_flips) {
  doc["flips"] = _num_flips;
}

TxPacket::TxPacket(int* feedback, int packet_size) {
  JsonArray feedback_arr = doc.createNestedArray("enc_feedback");
  for (int i = 0; i < packet_size; i++) {
    feedback_arr.add(feedback[i]);
  }
}

TxPacket::~TxPacket() {
  //delete(encoder_feedback);
}


/* ============================================== */
/*                      Comm                      */
/* ============================================== */
Comm::Comm() {
  hw_serial.begin(BAUD_RATE);
}


void Comm::set_callback(void (*_spin_callback)(RxPacket &rx)) {
  spin_callback = _spin_callback;

}

void Comm::transmit(TxPacket tx) {
  serializeJson(tx.doc, hw_serial); // Transmit json bytes
}


void Comm::spin() {
  if (hw_serial.available()) {
    char ch = hw_serial.read(); // Read a single character
    // Full msg recieved
    if (ch == '\n') {
      
      DeserializationError error = deserializeJson(rx_doc, rx_buffer); // Convert bytes to char array as json string

      // convert doc to packet
      RxPacket rx_packet;
      
      
      for (int i = 0; i < DEFAULT_PACKET_SIZE; i++) {
        rx_packet.step_cmd[i] = rx_doc["steps"][i];
      }
      
      spin_callback(rx_packet);
      // Reset buffer
      strncpy(rx_buffer, "", RX_BUFFER_SIZE);
      buffer_index = 0;
      
    } else {
      // Add char to buffer
      rx_buffer[buffer_index] = ch;
      buffer_index++;
    }

  }
}
