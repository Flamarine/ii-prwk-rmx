#!/usr/bin/env bash
set -e

rm -rf patches && mkdir patches

(
    cd ii && find . -type f
    cd ../work && find . -type f
) | sort -u | while read -r rel_path; do
    rel_path="${rel_path#./}"
    [ -z "$rel_path" ] && continue

    upstream_file="ii/$rel_path"
    work_file="work/$rel_path"

    if [ ! -f "$upstream_file" ] && [ -f "$work_file" ]; then
        patch_dir="patches/$(dirname "$rel_path")"
        mkdir -p "$patch_dir"

        diff -u /dev/null "$work_file" > "patches/$rel_path.diff" || true
        continue
    fi

    if ! cmp -s "$upstream_file" "$work_file" 2>/dev/null; then
        patch_dir="patches/$(dirname "$rel_path")"
        mkdir -p "$patch_dir"

        if [ -f "$work_file" ]; then
            diff -u "$upstream_file" "$work_file" > "patches/$rel_path.diff" || true
        else
            diff -u "$upstream_file" /dev/null > "patches/$rel_path.diff" || true
        fi
    fi
done

echo "Patches generated and savend to ./patches"
