#!/bin/sh -e
# Generate the content of nanorc

base="$(dirname "$0")/../src"

rm "$base/nanorc"
for n in "$base"/*.nanorc; do
    printf 'include "~/.nano/%s"\n' "$(basename "$n")" >> "$base/nanorc"
done
