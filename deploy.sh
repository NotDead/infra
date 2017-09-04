#!/bin/bash
cd ~
git clone https://github.com/Artemmkin/reddit.git ./reddit
cd reddit && bundle install
puma -d
ps aux | grep puma