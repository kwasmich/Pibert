#!/usr/bin/python3

#sudo apt install python3-pip libopenjp2-7 libtiff5
#sudo pip3 install Pillow

import datetime
import random
import os

first = datetime.date(1989, 4, 16)
last = datetime.date.today()
delta = last - first
deltaS = delta.total_seconds()
rand = random.randrange(0, deltaS)
randD = first + datetime.timedelta(seconds=rand)

os.system("$HOME/Pibert/dilbert_base.py " + str(randD))
