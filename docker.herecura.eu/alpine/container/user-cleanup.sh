#!/bin/sh

for user in $(cat /etc/passwd | awk -F':' '{print $1}' | grep -v root); do
    deluser "$user"
done
for group in $(cat /etc/group | awk -F':' '{print $1}' | grep -v root); do
    delgroup "$group"
done

