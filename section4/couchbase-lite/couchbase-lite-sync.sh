#!/bin/bash

CBL_ID="Your Couchbase Lite ID"
CBL_PASS="Your Couchbase Lite PASSWORD"
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
