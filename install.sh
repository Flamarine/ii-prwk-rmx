#!/usr/bin/env bash
./apply_patches.sh

./work/install.sh

rm -r ./work/cache
