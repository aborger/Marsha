import serial
import time

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



while True:

    try:
        data = arduino.read()
        if data:
            print(data)
    except KeyboardInterrupt:
        cmd = input("Enter Command: ")
        arduino.write(cmd.encode())
    except Exception as e:
        print(e)
        arduino.close()
