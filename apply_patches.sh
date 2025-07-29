#!/usr/bin/env bash
set -e

rm -rf work

cp -r ii work

find patches -type f -name '*.diff' | while read -r patch; do
    target_file="work/${patch#patches/}"
    target_file="${target_file%.diff}"

    mkdir -p "$(dirname "$target_file")"

    patch "$target_file" < "$patch"
done

echo "Patches applied to ./work"
