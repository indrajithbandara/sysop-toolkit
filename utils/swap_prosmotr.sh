#!/bin/bash

for fn in /proc/*/status
do
awk '/Name|VPid|VmSwap/ {printf $2" "}END{print""}' "$fn"
done
