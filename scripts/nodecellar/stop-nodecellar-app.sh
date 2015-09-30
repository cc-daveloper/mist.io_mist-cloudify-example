#!/bin/bash

set -e

PIDFile="/tmp/nodecellar.pid"
PID=$(<"$PIDFile")
kill -9 ${PID}

echo "Sucessfully stopped Nodecellar (${PID})"