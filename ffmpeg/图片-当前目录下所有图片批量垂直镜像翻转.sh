#!/bin/bash

DIR="./"
cd $DIR
mkdir rotate_des
for k in $(ls $DIR |grep png)
do
  #[ -d $k ] && du -sh $k
  printf $k
  ffmpeg -i $k -vf vflip rotate_des/$k
done


for k in $(ls $DIR |grep jpg)
do
  #[ -d $k ] && du -sh $k
  printf $k
  ffmpeg -i $k -vf vflip rotate_des/$k
done



for k in $(ls $DIR |grep jpeg)
do
  #[ -d $k ] && du -sh $k
  printf $k
  ffmpeg -i $k -vf vflip rotate_des/$k
done
