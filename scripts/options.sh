#!/bin/bash

option="$1"

case "${option}" in
	start) echo "start";;
        stop) echo "stop";;
        clean) echo "clean";;
	*) echo $"ERROR--> Usage: $0 {start|stop|clean}"
	   exit 1
esac
