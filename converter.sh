#!/bin/bash

./a.out

echo "Finiti i calcoli"

gnuplot gnuscript

echo "Stampati i png"
for ((j=0;j<9;j+=1)); do #ji**.png->videoji.mp4
	for ((i=0;i<10;i+=1)); do
		convert -delay 10 $j$i*.png out$j$i.gif
		ffmpeg -i out$j$i.gif -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" video$j$i.mp4
	done
done

echo "Stampati i video"

touch listtomerge.txt
for f in ./video*.mp4; do echo "file '$f'" >> listtomerge.txt; done

ffmpeg -f concat -safe 0 -i listtomerge.txt -c copy output.mp4

rm listtomerge.txt
rm *.png
rm video*.mp4
rm out*.gif
rm fort.*

echo "Finito"
