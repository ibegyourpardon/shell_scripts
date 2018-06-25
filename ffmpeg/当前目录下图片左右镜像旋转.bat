md rotate_des
for /f %%i in ('dir /b *.png') do (ffmpeg -i %%i -vf hflip rotate_des/%%i)
for /f %%i in ('dir /b *.jpg') do (ffmpeg -i %%i -vf hflip rotate_des/%%i)
for /f %%i in ('dir /b *.jpeg') do (ffmpeg -i %%i -vf hflip rotate_des/%%i)