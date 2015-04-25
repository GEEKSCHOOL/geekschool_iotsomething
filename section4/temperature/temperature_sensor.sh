#!/bin/bash

# gcc -o temperature -lwiringpi temperature.c

CBL_ID="Your Couchbase Lite ID"
CBL_PASS="Your Couchbase Lite PASSWORD"
CBL_IP="localhost"
CBL_PORT=5984
CBL_DATABASE="geek"

# curl -v -X PUT http://${CBL_ID}:${CBL_PASS}@${CBL_IP}:${CBL_PORT}/${CBL_DATABASE}/

TEMP=`sudo /home/pi/Document/C/temperature`
echo "TEMP = ${TEMP}"

echo "curl -v -X POST -H 'Content-Type: application/json' -d '${TEMP}' http://${CBL_ID}:${CBL_PASS}@${CBL_IP}:${CBL_PORT}/geek/"
curl -v -X POST -H 'Content-Type: application/json' -d "${TEMP}" http://${CBL_ID}:${CBL_PASS}@${CBL_IP}:${CBL_PORT}/${CBL_DATABASE}/
