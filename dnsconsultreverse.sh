#!/bin/bash

for i in $(seq 224 239);do
host -t ptr 37.59.174.$i | grep -v "37-59-174" | cut -d " " -f 5;
done
