#!/bin/bash


#This script takes vertical 4k videos, and crops out 1080p panning top to bottom

#find out number of frames in a video
#ffmpeg -i $filename -map 0:v:0 -c copy -f null -y /dev/null 2>&1 | grep -Eo 'frame= *[0-9]+ *' | grep -Eo '[0-9]+' | tail -1

#now, let's actually crop/pan the video. pick and choose as the case may need:
#set pixel format	-pix_fmt yuvj420p
#half speed 		setpts=2.0*PTS
#rotate video		transpose=2
#pan top to bottom	crop=w=1920:h=1080:x=120:y='n/205*ih-1080'
#				width=1920 
#				height=1080
#				x position=trim (2160-1920)/2 pixels
#				y position=pan from top to bottom
#sepia 			colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0::.272:.534:.131"
#b&w 			colorchannelmixer=.2:.2:.2:0:.2:.2:.2:.0:.2:.2:.2"
#drop audio		-an
for var in "$@"
do
	echo ffmpeg -i $var -pix_fmt yuvj420p -vf "crop=w=1920:h=1080:y='n/`ffmpeg -i $var -map 0:v:0 -c copy -f null -y /dev/null 2>&1 | grep -Eo 'frame= *[0-9]+ *' | grep -Eo '[0-9]+' | tail -1`*(ih-1080)':x='120', colorchannelmixer=.2:.2:.2:0:.2:.2:.2:0:.2:.2:.2" -an crop/$var &
	ffmpeg -i $var -pix_fmt yuvj420p -vf "crop=w=1920:h=1080:y='n/`ffmpeg -i $var -map 0:v:0 -c copy -f null -y /dev/null 2>&1 | grep -Eo 'frame= *[0-9]+ *' | grep -Eo '[0-9]+' | tail -1`*(ih-1080)':x='120', colorchannelmixer=.2:.2:.2:0:.2:.2:.2:0:.2:.2:.2" -an crop/$var &
done
wait
