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

NODEJS_BINARIES_PATH='/tmp/nodejs/nodejs-binaries'
NODECELLAR_SOURCE_PATH='/tmp/nodecellar/nodecellar-source'
STARTUP_SCRIPT='server.js'

COMMAND="${NODEJS_BINARIES_PATH}/bin/node ${NODECELLAR_SOURCE_PATH}/${STARTUP_SCRIPT}"

export NODECELLAR_PORT=8080
export MONGO_HOST='localhost'
export MONGO_PORT=27017
export LC_ALL=C
echo "MongoDB is located at ${MONGO_HOST}:${MONGO_PORT}"
echo "Starting nodecellar application on port ${NODECELLAR_PORT}"

echo "${COMMAND}"
nohup ${COMMAND} > /dev/null 2>&1 &
PID=$!

wait_for_server ${NODECELLAR_PORT} 'Nodecellar'

# this runtime porperty is used by the stop-nodecellar-app.sh script.
echo ${PID} > /tmp/nodecellar.pid


echo "Sucessfully started Nodecellar (${PID})"
