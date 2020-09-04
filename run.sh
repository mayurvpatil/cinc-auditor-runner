#!/bin/sh 
set -xv

bundle install &&
#inspec vendor --overwrite

if [ "$SPEC_OS" = "windows" ]
then
    if [ -n $SPEC_PASS ]
    then
        echo "Windows call with password"
        if [ -n $SPEC_PORT ]
            then PORT=${SPEC_PORT}
        else
            PORT=5985
        fi
        echo ${SPEC_OS}
        echo $(printf "%s" ${SPEC_PASS})
        echo ${PORT}
        echo ${SPEC_HOST_NAME} 
        echo ${SPEC_USER}
        cinc-auditor exec  controls/windows_spec.rb -b "winrm" --host ${SPEC_HOST_NAME} --port $PORT --user "${SPEC_USER}" --password $(printf "%s" ${SPEC_PASS}) --ssl --self-signed  --reporter  html >> report/result.html
        cinc-auditor exec  controls/windows_spec.rb -b "winrm" --host ${SPEC_HOST_NAME} --port $PORT --user "${SPEC_USER}" --password $(printf "%s" ${SPEC_PASS}) --ssl --self-signed  --reporter  json >> report/result.json
    else 
        echo "Windows call with key."
    fi
elif [ "$SPEC_OS" = "linux" ]
then
    echo "Linux support coming soon"
fi


