#ifndef Comm_h
#define Comm_h

#include <Arduino.h>
#include <ArduinoJson.h>

#define BAUD_RATE   115200
#define RX_BUFFER_SIZE 200
#define TX_BUFFER_SIZE 400

#define DEFAULT_PACKET_SIZE   6

#define hw_serial   Serial


class RxPacket {
  public:
    int* step_cmd;
    int packet_size;

    bool led_state; // debug

    RxPacket();
    //RxPacket(const JsonDocument &doc); // Construct from json
    ~RxPacket();

};

class TxPacket {
  public:
    StaticJsonDocument<TX_BUFFER_SIZE> doc;


    TxPacket(int _num_flips);
    TxPacket(int* _feedback, int _packet_size);
    ~TxPacket();

    
};

class Comm {
  private:
    StaticJsonDocument<RX_BUFFER_SIZE> rx_doc;
    void (*spin_callback)(RxPacket &rx); // points to callback function

    char rx_buffer[RX_BUFFER_SIZE];
    int buffer_index = 0;
  public:
    Comm();
    void set_callback(void (*_spin_callback)(RxPacket &rx));

    void transmit(TxPacket tx);
    void spin();


  
};

#endif
