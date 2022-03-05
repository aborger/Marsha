import serial
import time
import json
from sys import exit

connected = False
while not connected:
    try:
        arduino = serial.Serial(
            port = '/dev/ttyACM0',
            baudrate = 115200,
            bytesize = serial.EIGHTBITS,
            parity = serial.PARITY_NONE,
            stopbits = serial.STOPBITS_ONE,
            timeout = 5,
            xonxoff = False,
            rtscts = False,
            dsrdtr = False,
            writeTimeout = 2
        )
        connected = True
    except KeyboardInterrupt:
        exit()
    except Exception as e:
        print(e)
        time.sleep(1)

data = {"led": 1}


while True:
    try:
        char = arduino.read().decode()
        if char:
            data += char
        if char == '\n':
            print(data)
            data = ""

    except KeyboardInterrupt:
        cmd = 0x000A
        print(bytes(cmd))
        arduino.write(bytes(cmd))