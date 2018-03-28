#!/bin/sh

#straight from http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html
#I export to gif only because twitter automatically loops gifs, but doesn't loop mp4s.

palette="/tmp/palette.png"

#filters="fps=15,scale=320:-1:flags=lanczos"
filters="fps=7,scale=480:-1:flags=lanczos"

ffmpeg -v warning -i $1 -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2
