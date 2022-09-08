#!/bin/sh
sudo usermod -aG dialout $(whoami)
npm start