#!/usr/bin/python3

from gpiozero import Button
from signal import pause
import os

def name():
    print("Attempting to print...")
    # TODO Path should be relative
    os.system("$HOME/Pibert/bin/dilbert_rnd.py")

button = Button(18)

# button.when_pressed = led.on
button.when_released = name

pause()
