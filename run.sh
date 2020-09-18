#!/bin/sh 
set -xv

bundle install &&
#inspec vendor --overwrite

if [ -n "$INSPEC_PASSWORD" ]
then
    CRED="--password " $(printf "%s" ${INSPEC_PASSWORD})
else
    CRED="-i " $INSPEC_SSH_KEY 
fi

if [ "$INSPEC_OS" = "windows" ]
then
    echo " Running cinc-auditor for windows server ..."
    if [ -n "$INSPEC_PORT" ]
        then PORT=${INSPEC_PORT}
    else
        PORT=5985
    fi

    cinc-auditor exec  controls/windows_spec.rb -b "winrm" --host ${INSPEC_IP} --port $PORT --user "${INSPEC_USER}" $CRED  --ssl --self-signed  --reporter  html >> report/result.html
    cinc-auditor exec  controls/windows_spec.rb -b "winrm" --host ${INSPEC_IP} --port $PORT --user "${INSPEC_USER}" $CRED  --ssl --self-signed  --reporter  json >> report/result.json

elif [ "$SPEC_OS" = "linux" ]
then
    echo " Running cinc-auditor for windows server ..."
    cinc-auditor exec  controls/linux_spec.rb -b "ssh" --host ${INSPEC_IP} --port 22 --user "${INSPEC_USER}" $CRED --ssl --self-signed  --reporter  html >> report/result.html
    cinc-auditor exec  controls/linux_spec.rb -b "ssh" --host ${INSPEC_IP} --port 22 --user "${INSPEC_USER}" $CRED --ssl --self-signed  --reporter  json >> report/result.json
fi


