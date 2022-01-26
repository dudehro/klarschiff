#!/bin/bash

filename=$(date +"%Y_%m_%d").csv
wget -O csv/${filename} https://geo.sv.rostock.de/download/opendata/klarschiffhro-meldungen/klarschiffhro-meldungen.csv
tar -rf csv.tar csv/${filename}
rm csv/${filename}
