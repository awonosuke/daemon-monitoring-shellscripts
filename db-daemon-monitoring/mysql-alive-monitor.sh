#!/bin/sh

IS_ALIVE="mysqld is alive"
RESULT=`mysqladmin --defaults-extra-file=filepath ping 2>&1`

if [ "$IS_ALIVE" != "$RESULT" ]; then
curl=`cat <<EOS
curl
  -X POST
  https://hooks.slack.com/services/xxx
  -H 'Content-Type: application/json'
  --data '{"text": "<!channel> mysqld is dead"}'
EOS`
eval $curl > /dev/null 2>&1
fi
