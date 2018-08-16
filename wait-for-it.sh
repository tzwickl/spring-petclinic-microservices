#!/usr/bin/env bash

counter=1
while [ $counter -le $2 ]
do

response=$(
    curl $1 \
        --write-out %{http_code} \
        --silent \
        --output /dev/null \
)
if [ "$response" -eq 200 ]; then
    exit 1
fi

sleep 1
((counter++))

done

exit 0
