#!/bin/bash

set -e

PIDFile="/tmp/mongodb.pid"
PID=$(<"$PIDFile")

kill -9 ${PID}

echo "Sucessfully stopped MongoDB (${PID})"