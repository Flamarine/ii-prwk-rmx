#!/usr/bin/env bash
./apply_patches.sh

./work/install.sh

[ -d "work/cache" ] && rm -r "work/cache"
