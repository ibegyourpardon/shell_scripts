#/bin/bash
brew install ffmpeg

brew install ffmpeg --with-fdk-aac --with-ffplay --with-freetype --with-libass --with-libquvi --with-libvorbis --with-libvpx --with-opus --with-x265

#为啥要装两次我也不知道，反正装了就装了。

brew update && brew upgrade ffmpeg
