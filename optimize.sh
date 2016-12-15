#!/usr/bin/env bash

src=img/
des=img-opt/

for jpg in ${src}/*.jpg
do
    echo -e "\n$(date)\t$jpg"

    resized="${des}/$(basename $jpg .jpg)_resized.jpg"
    optimized="${des}/$(basename $jpg .jpg)_optimized.jpg"

    if [[ -f "$optimized" && "$optimized" -nt "$jpg" ]]
    then
	continue
    fi

    convert -geometry 150x "$jpg" "$resized"
    jpegoptim --strip-all --max=90 --stdout "$resized" > "$optimized"
    rm -f "$resized"

done
