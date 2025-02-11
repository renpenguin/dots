# Nice MacOS-like video preview to be used in file manager
ffplay \
    -autoexit \
    -volume 30 \
    -vf scale=-1:800 \
    -seek_interval 3 \
    -i "$*"
