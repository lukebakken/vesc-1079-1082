#!/bin/sh

set -eu

for DC in hdc wdc odc
do
    defs_in="rmq-$DC/definitions.json.in"
    defs_out="rmq-$DC/definitions.json"
    sed -e "s/@@RABBITMQ_QUEUE_TYPE@@/$RABBITMQ_QUEUE_TYPE/g" $defs_in > $defs_out
done
