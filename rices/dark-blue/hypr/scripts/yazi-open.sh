#! /bin/sh
export YAZI_LOC="$(mktemp -t "yazi-cwd.XXXXXX")"
yazi --cwd-file="$YAZI_LOC"
cd -- "$(cat $YAZI_LOC)"
rm -f -- "$YAZI_LOC"
zsh -i
