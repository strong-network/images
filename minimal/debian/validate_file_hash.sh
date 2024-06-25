#!/usr/bin/env bash
hash="$1"
filename="$2"
echo "$hash $filename" | sha256sum --check || exit 1