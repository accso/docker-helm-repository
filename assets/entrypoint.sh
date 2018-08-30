#! /bin/bash

if [ "$1" == "reload" ] ; then
    PID=`cat /tmp/bash.pid`
    echo "Send SIGUSR1 to entrypoint.sh with PID=${PID}..."
    kill -USR1 ${PID}
    exit 0
fi

function reload_server {
    echo "Received signal USR1!"
    RELOAD=1
}

function exit_server {
    echo "Received signal HUP, INT, or TERM!"
    RELOAD=1
    EXIT=1
}

trap "reload_server" USR1
trap "exit_server" HUP INT TERM

echo $$ > /tmp/bash.pid

EXIT=0
until [  $EXIT -ne 0 ] ; do
    echo "Starting helm using command line..."
    echo "    /bin/helm serve --repo-path /charts $@"
    /bin/helm serve --repo-path /charts "$@"
    HELM_PID=$!

    RELOAD=0
    until [  $RELOAD -ne 0 ]; do
	sleep 1
    done

    echo "Send SIGHUP to helm..."
    kill -HUP ${HELM_PID}
done
