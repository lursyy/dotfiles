#!/bin/bash

dir="$HOME/.cache/himawaripy"

himawaripy -l 4 --auto-offset --dont-change
convert -border 5% -bordercolor black $dir/himawari*.png $dir/output.png
feh --bg-max $dir/output.png

