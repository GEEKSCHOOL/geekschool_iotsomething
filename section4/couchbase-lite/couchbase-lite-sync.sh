#!/bin/bash

CBL_ID="5827a757-e613-4a2c-b73f-1a64dc71e93b"
CBL_PASS="ef633203-75b2-49bb-a167-a6a4980e73be"
CBL_IP="localhost"
CBL_PORT=5984
CBL_DATABASE="geek"

SGW_IP="52.68.93.247"
SGW_PORT=4984
SGW_DATABASE="geek"

POST_DATA="{\"source\":\"${CBL_DATABASE}\",\"target\":\"http://${SGW_IP}:${SGW_PORT}/${SGW_DATABASE}/\",\"continuous\": true}"

echo "POST Data : ${POST_DATA}"
echo "curl -v -X POST -d '${POST_DATA}' http://${CBL_ID}:${CBL_PASS}@${CBL_IP}:${CBL_PORT}/_replicate"
curl -v -X POST -d "${POST_DATA}" http://${CBL_ID}:${CBL_PASS}@${CBL_IP}:${CBL_PORT}/_replicate
