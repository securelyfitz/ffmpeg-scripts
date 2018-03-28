# ffmpeg-scripts
Scripts to cut and trim videos in ffmpeg for use in presentations


I wanted to try out a more visually pleasing presenation style. I wanted to convey some details about working with hardware, but didn't want them to take over the whole presentation. I decided to make a few dark, black-and-white, continuously looping videos to use as backgrounds. 

Doing this in a video editing GUI is fine for one or two videos - but I knew i'd be working with a dozen or more, so I figured it would be worth doing it all in a script

## Source Material
I used my phone (pixel 2) to capture all the videos in 4K while in a phone holder or on a tripod, with bright lighting. This means i got very steady, but static, shots.

## Cropping and Panning
To make it a bit more dynamic, i cropped 1080p out of each of the 4k source videos, panning across the frame. h-pan.sh should work with any size video but I used it with 4k. It'll start at the middle left of the video and pan to the middle right.

If you've got vertical source videos, v-pan.sh will pan down, cropping out 1080p. This is hard-coded and will only really work on 4k source material.

I started by running h-pan.sh on all my capture videos, all at once, to see what looked good. Then for some videos tweaked the pan/crop/angles and sometimes trimmed the beginning and end points of the videos

## Looping
To make the videos seamless, i trimmed the first N seconds and faded it into the last N seconds. loop.sh should do this, and you can adjust the duration of the crossfade, as long as it's less than 1/2 the total source video duration. The videos start cleanly, but then the last N seconds is the fade out and fade in, so that when it loops, it goes back to the 100% faded in starting point. 

## GIFs
I export to gif only because twitter automatically loops gifs, but doesn't loop mp4s. IIRC twitter converts GIFs to MP4s for serving, making it even more ridiculous.
These commands were taken straight from http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html
The proper pronounciation of this script is /tuːgIf/ with a hard G to remove any chance of ambiguity that the speaker might be referring to the JIFF image file format or an oversweetened brand of peanut butter
