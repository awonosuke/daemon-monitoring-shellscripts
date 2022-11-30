#!/bin/sh

IS_ALIVE="accepting connections"
RESULT=`pg_isready -h hostname -p portnumber 2>&1`

# "accepting connections"が含まれてない(終了ステータスが0以外)場合、slackに通知
if [ ! `echo "$RESULT" | grep "$IS_ALIVE"` ]; then
curl=`cat <<EOS
curl
  -X POST
  https://hooks.slack.com/services/xxx
  -H 'Content-Type: application/json'
  --data '{"text": "<!channel> postgres is dead"}'
EOS`
eval $curl > /dev/null 2>&1
fi
