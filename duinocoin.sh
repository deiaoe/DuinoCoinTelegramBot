#!/bin/bash

TOKEN="746247733:AAGCOzplpUAx1gJYCpQoEtzgc7Gt9ZftBmM"
ID="481268297"
WALLET="raaditya990"

URL="https://api.telegram.org/bot$TOKEN/sendMessage"
MSG="ᕲ DuinoCoin"
JSON=$(curl -s -X GET https://server.duinocoin.com/users/$WALLET -H "Accept: application/json" | jq .)
BALANCE=$(echo $JSON | jq '.result.balance.balance')
WORKERS=$(echo $JSON | jq '.result.miners' | jq '.[].identifier')

if [ $? -ne 0 ]
then
        exit 0
else
        /usr/bin/curl -s -X POST $URL \
		-d chat_id=$ID \
		-d parse_mode=HTML \
		-d text="$(printf "$MSG\n\t\t- \U1FA99 Balance: <code>$BALANCE</code>\n\t\t- \U26CF Workers:\n<code>$WORKERS</code>")" \
		> /dev/null 2>&1
        exit 0
fi
