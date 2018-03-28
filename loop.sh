#!/bin/bash

#this takes a video, cuts the first N seconds, fades it into the last N seconds, and results in a video that starts clean and can loop into itself indefinitely.
#I use this for video backgrounds that fade in and fade out when the slide is selected/deselected.


#len	 	the length of the input video
#duration	duration of the crossfade. Must be less than 1/2 $len
#outlen		length of the output video
#out		time where the fadeout starts


#breakdown of ffmpeg command line:

#first input stream: skip first $duration secs 	-ss $duration -i $var 
#second input stream: start normally		-i $var 
#do lots of stuff:				-filter_complex "
#   First input:fade out starting at time $out 	[0:v]fade=t=out:st=$out:d=$duration:alpha=1,setpts=PTS-STARTPTS[va0];
#   Second input: fade in from the begining	[1:v]fade=t=in:st=0:
#	clip after the crossfade time		d=$duration:alpha=1,
#	and start it at time $out		setpts=PTS-STARTPTS+$out/TB[va1]
#Output: overlay both inputs			[va0][va1]overlay[outv]" -map [outv] 
#clip final output to $outlen			-to $outlen loop/$var &


for var in "$@"
do
#for lopping
	len=`ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 $var | cut -f 1 -d .`
	duration=5
	let outlen=len-duration
	let out=len-duration-duration
	echo ffmpeg -ss $duration -i $var -i $var -filter_complex "[0:v]fade=t=out:st=$out:d=$duration:alpha=1,setpts=PTS-STARTPTS[va0];[1:v]fade=t=in:st=0:d=$duration:alpha=1,setpts=PTS-STARTPTS+$out/TB[va1];[va0][va1]overlay[outv]" -map [outv] -to $outlen loop$var &
	ffmpeg -ss $duration -i $var -i $var -filter_complex "[0:v]fade=t=out:st=$out:d=$duration:alpha=1,setpts=PTS-STARTPTS[va0];[1:v]fade=t=in:st=0:d=$duration:alpha=1,setpts=PTS-STARTPTS+$out/TB[va1];[va0][va1]overlay[outv]" -map [outv] -to $outlen loop$var &
done
wait
