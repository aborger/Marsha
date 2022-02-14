#!/usr/bin/env python
import RPi.GPIO as GPIO
import time
pin = 21
GPIO.setmode(GPIO.BCM)
GPIO.setup(pin, GPIO.IN)

def error_detected(channel):
    print("Error Detected!")

def main():

    initial_time = None

    try:
        print("Waiting for TE...")
        GPIO.wait_for_edge(pin, GPIO.RISING)
        initial_time = time.time()
        print("Waiting to detect error...")
        GPIO.add_event_detect(pin, GPIO.FALLING, callback=error_detected)

        time.sleep(3)

        print("TE detected")
    finally:

        GPIO.cleanup()



if __name__ == "__main__":

    main()