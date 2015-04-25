#!/bin/bash

# gcc -o temperature -lwiringpi temperature.c

CBL_ID="5827a757-e613-4a2c-b73f-1a64dc71e93b"
CBL_PASS="ef633203-75b2-49bb-a167-a6a4980e73be"
CBL_IP="localhost"
CBL_PORT=5984
CBL_DATABASE="geek"

# curl -v -X PUT http://${CBL_ID}:${CBL_PASS}@${CBL_IP}:${CBL_PORT}/${CBL_DATABASE}/

TEMP=`sudo ./temperature`
echo "TEMP = ${TEMP}"

echo "curl -v -X POST -H 'Content-Type: application/json' -d '${TEMP}' http://${CBL_ID}:${CBL_PASS}@${CBL_IP}:${CBL_PORT}/geek/"
curl -v -X POST -H 'Content-Type: application/json' -d "${TEMP}" http://${CBL_ID}:${CBL_PASS}@${CBL_IP}:${CBL_PORT}/${CBL_DATABASE}/
