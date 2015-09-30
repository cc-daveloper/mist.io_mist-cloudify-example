#!/bin/bash

set -e


function get_response_code() {

    port=$1

    set +e

    curl_cmd=$(which curl)
    wget_cmd=$(which wget)

    if [[ ! -z ${curl_cmd} ]]; then
        response_code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${port})
    elif [[ ! -z ${wget_cmd} ]]; then
        response_code=$(wget --spider -S "http://localhost:${port}" 2>&1 | grep "HTTP/" | awk '{print $2}' | tail -1)
    else
        echo "Failed to retrieve response code from http://localhost:${port}: Neither 'cURL' nor 'wget' were found on the system"
        exit 1;
    fi

    set -e

    echo ${response_code}

}

function wait_for_server() {

    port=$1
    server_name=$2

    started=false

    echo "Running ${server_name} liveness detection on port ${port}"

    for i in $(seq 1 120)
    do
        response_code=$(get_response_code ${port})
        echo "[GET] http://localhost:${port} ${response_code}"
        if [ ${response_code} -eq 200 ] ; then
            started=true
            break
        else
            echo "${server_name} has not started. waiting..."
            sleep 1
        fi
    done
    if [ ${started} = false ]; then
        echo "${server_name} failed to start. waited for a 120 seconds."
        exit 1
    fi
}

PORT=27017
MONGO_ROOT_PATH='/tmp/mongodb'
MONGO_DATA_PATH=${MONGO_ROOT_PATH}/data
MONGO_BINARIES_PATH=${MONGO_ROOT_PATH}/mongodb-binaries
COMMAND="${MONGO_BINARIES_PATH}/bin/mongod --port ${PORT} --dbpath ${MONGO_DATA_PATH} --rest --journal --shardsvr --fork --logpath /tmp/mongo.log"

echo "${COMMAND}"
export LC_ALL=C
${COMMAND} 
PID=`pgrep mongod`
sleep 10
#PID=$!

MONGO_REST_PORT=`expr ${PORT} + 1000`
wait_for_server ${MONGO_REST_PORT} 'MongoDB'

# this runtime porperty is used by the stop-mongo script.
echo ${PID} > /tmp/mongodb.pid

echo "Sucessfully started MongoDB (${PID})"
echo "paparia" > output
touch /tmp/lola