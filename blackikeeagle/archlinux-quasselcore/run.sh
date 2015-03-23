#!/bin/bash

docker run --name quasselcore \
    -v /var/lib/quassel:/var/lib/quassel \
    -p 0.0.0.0:4242:4242 blackikeeagle/archlinux-quasselcore

