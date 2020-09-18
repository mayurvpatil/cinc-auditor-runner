#!/bin/sh 
set -xv

bundle install &&
#inspec vendor --overwrite

if [ -n "$INSPEC_PASSWORD" ]
then
    CRED_TYPE="--password"
    CRED_VALUE=$(printf "%s" ${INSPEC_PASSWORD})

else
    CRED_TYPE="-i "
    CRED_VALUE=$(printf "%s" ${INSPEC_SSH_KEY})
fi

echo "----------------------------"
echo $CRED_TYPE 
echo "**********"
echo $CRED_VALUE
echo "----------------------------"

if [ "$INSPEC_OS" = "windows" ]
then
    echo " Running cinc-auditor for windows server ..."
    if [ -n "$INSPEC_PORT" ]
        then PORT=${INSPEC_PORT}
    else
        PORT=5985
    fi

    cinc-auditor exec  controls/windows_spec.rb -b "winrm" --host ${INSPEC_IP} --port $PORT --user "${INSPEC_USER}" $CRED_TYPE $CRED_VALUE --ssl --self-signed  --reporter  html >> report/result.html
    cinc-auditor exec  controls/windows_spec.rb -b "winrm" --host ${INSPEC_IP} --port $PORT --user "${INSPEC_USER}" $CRED_TYPE $CRED_VALUE --ssl --self-signed  --reporter  json >> report/result.json

elif [ "$SPEC_OS" = "linux" ]
then
    echo " Running cinc-auditor for Linux server ..."
    cinc-auditor exec  controls/linux_spec.rb -b "ssh" -t ssh://$INSPEC_USER@$INSPEC_IP $CRED_TYPE $CRED_VALUE --ssl --self-signed  --reporter  html >> report/result.html
    cinc-auditor exec  controls/linux_spec.rb -b "ssh" -t ssh://$INSPEC_USER@$INSPEC_IP $CRED_TYPE  $CRED_VALUE --ssl --self-signed  --reporter  json >> report/result.json
fi


