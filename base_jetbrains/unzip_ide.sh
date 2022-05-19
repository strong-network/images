#!/usr/bin/env sh

mkdir /tmp/ide
tar -C /tmp/ide -xzf /ide.tar.gz
rm ide.tar.gz
cd /tmp/ide
find . -maxdepth 1 -type d -name * -execdir mv {} /ide \\;
cd /
rm -rf /tmp/ide