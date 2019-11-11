#!/usr/bin/python3

#sudo apt install python3-pip libopenjp2-7 libtiff5
#sudo pip3 install Pillow

import urllib.request
import re
import sys
import datetime
import os
from PIL import Image, ImageOps, ImageFilter, ImageEnhance

if len(sys.argv) > 1:
    os.system('echo "' + sys.argv[1] + '\\n" > /dev/serial0')
else:
    os.system('echo "' + str(datetime.date.today()) + '\\n" > /dev/serial0')

if len(sys.argv) > 1:
    dilbertURL = "https://dilbert.com/strip/" + sys.argv[1]
else:
    dilbertURL = "https://dilbert.com"

dilbertURLResponse = urllib.request.urlopen(dilbertURL)
dilbertURLData = dilbertURLResponse.read()      # a `bytes` object
dilbertHTML = dilbertURLData.decode("utf-8")
#print(dilbertHTML)

imageURLRegExp = re.compile('data-image="([^\s]*)"')
imageURL = imageURLRegExp.findall(dilbertHTML)

#print("https:" + imageURL[0])

#imageURLResponse = urllib.request.urlopen("https:" + imageURL[0])
#imageURLData = imageURLResponse.read()      # a `bytes` object
#print(sys.getsizeof(imageURLData))
file_name, headers = urllib.request.urlretrieve("https:" + imageURL[0])
#print(file_name)

image = Image.open(file_name)
image = image.convert('L')

if (image.height / image.width) > 0.4:
    image1 = image.crop(box=(0, 25, image.width, 225))
    image2 = image.crop(box=(0, 237, image.width, 437))
    image = Image.new("L", (image.width * 2 + 11, 200), color=255);
    image.paste(image1)
    image.paste(image2, box=(image1.width + 11, 0, image1.width + 11 + image2.width, image2.height))


h = 384
w = round(image.width * 384 / image.height)
out = image.resize((w, h), Image.LANCZOS) # resampling is not working here

out = out.rotate(-180, expand=1)
#out = ImageOps.invert(out)

#fn = lambda x : 255 if x > 88 else 0
#out = out.convert('L').point(fn, mode='1')
out = out.convert('1')

out.save("resize.png", "png");

#if len(sys.argv) > 1:
#    os.system("echo " + sys.argv[1] + " > /dev/serial0")
#else:
#    os.system("echo " + str(datetime.date.today()) + " > /dev/serial0")

os.system("lp -o media=X48MMY3276MM resize.png")
