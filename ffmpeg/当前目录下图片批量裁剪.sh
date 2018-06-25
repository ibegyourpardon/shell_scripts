#!/bin/bash
#其中的 crop=1080:1080:0:420 才裁剪参数，具体含义是 crop=width:height:x:y，其中 width 和 height 表示裁剪后的尺寸，x:y 表示裁剪区域的左上角坐标。比如当前这个示例，我们只需要保留竖向视频的中间部分，所以 x 不用偏移，故传入0，而 y 则需要向下偏移：(1920 – 1080) / 2 = 420\
# 也可以写入具体坐标
DIR="./"
cd $DIR
#mkdir rotate_des
for k in $(ls $DIR |grep png)
do
  #[ -d $k ] && du -sh $k
  printf $k
  ffmpeg -i $k -strict -2 -vf crop=1125:1090:0:939 /d/des/$k
done


