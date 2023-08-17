#!/bin/sh

set -eu

for DC in hdc wdc odc
do
    defs_in="rmq-$DC/definitions.json.$RABBITMQ_QUEUE_TYPE"
    defs_out="rmq-$DC/definitions.json"
    cp -vf $defs_in $defs_out
done
