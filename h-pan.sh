#!/bin/bash


#This script takes 4k videos, and crops out 1008p panning across the middle

#find out number of frames in a video
#ffmpeg -i $filename -map 0:v:0 -c copy -f null -y /dev/null 2>&1 | grep -Eo 'frame= *[0-9]+ *' | grep -Eo '[0-9]+' | tail -1

#now, let's actually crop/pan the video. pick and choose as the case may need:
#set pixel format	-pix_fmt yuvj420p
#half speed 		setpts=2.0*PTS
#flip video		transpose=2,transpose=2
#pan left to right	crop=w=iw/2:h=ih/2:x='n/205*iw/2':y='ih/4'
#				width=half width 
#				height=half height
#				x position=n/numframes * pan distance
#				y position=trim top and bottom 1/4
#sepia 			colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0::.272:.534:.131"
#b&w 			colorchannelmixer=.2:.2:.2:0:.2:.2:.2:.0:.2:.2:.2"
#drop audio		-an

for var in "$@"
do
	echo ffmpeg -i $var -pix_fmt yuvj420p -vf "setpts=2.0*PTS,crop=w=iw/2:h=ih/2:x='n/`ffmpeg -i $var -map 0:v:0 -c copy -f null -y /dev/null 2>&1 | grep -Eo 'frame= *[0-9]+ *' | grep -Eo '[0-9]+' | tail -1`*iw/2':y='ih/4', colorchannelmixer=.2:.2:.2:0:.2:.2:.2:0:.2:.2:.2" -an crop$var &
	ffmpeg -i $var -pix_fmt yuvj420p -vf "setpts=2.0*PTS,crop=w=iw/2:h=ih/2:x='n/`ffmpeg -i $var -map 0:v:0 -c copy -f null -y /dev/null 2>&1 | grep -Eo 'frame= *[0-9]+ *' | grep -Eo '[0-9]+' | tail -1`*iw/2':y='ih/4', colorchannelmixer=.2:.2:.2:0:.2:.2:.2:0:.2:.2:.2" -an crop$var &
done
wait
