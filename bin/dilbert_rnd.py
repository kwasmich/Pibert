#!/usr/bin/python3

import datetime
import random
import os

first = datetime.date(1989, 4, 16)
last = datetime.date.today()
delta = last - first
deltaS = delta.total_seconds()
rand = random.randrange(0, deltaS)
randD = first + datetime.timedelta(seconds=rand)

# TODO Path should be relative
os.system("$HOME/Pibert/bin/dilbert_base.py " + str(randD))
