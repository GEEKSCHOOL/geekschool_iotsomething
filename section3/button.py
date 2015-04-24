# -*- coding: utf-8 -*-

import RPi.GPIO as GPIO

OUTPUT_PIN = 4
INPUT_PIN = 17

GPIO.setmode(GPIO.BCM)
GPIO.setup(OUTPUT_PIN, GPIO.OUT)
GPIO.setup(INPUT_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

GPIO.output(OUTPUT_PIN, GPIO.HIGH)

pin_status = GPIO.LOW
while True:
    if GPIO.input(INPUT_PIN) == GPIO.HIGH:
        GPIO.output(OUTPUT_PIN, pin_status)
        if pin_status == GPIO.LOW:
            pin_status = GPIO.HIGH
        else:
            pin_status = GPIO.LOW
        while GPIO.input(INPUT_PIN) == GPIO.HIGH:
            pass
