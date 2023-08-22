# -*- coding: utf-8 -*-
# pylint: disable=C0111,C0103,R0205

import argparse
import logging
import pika

log_fmt = "%(asctime)s.%(msecs)03d %(levelname)s %(message)s"
log_date_fmt = "%Y-%m-%d %H:%M:%S"
logging.basicConfig(level=logging.INFO, format=log_fmt, datefmt=log_date_fmt)
logger = logging.getLogger()

parser = argparse.ArgumentParser(
    prog="consume.py", description="consume from inventory-fed"
)
parser.add_argument("-p", "--port", default="5672", type=int)
parser.add_argument("-v", "--vhost", default="/")
parser.add_argument("-l", "--log-every", default="1000", type=int)
parser.add_argument("-q", "--prefetch", default="1", type=int)
ns = parser.parse_args()
rmq_port = ns.port
log_every = ns.log_every
vhost = ns.vhost
prefetch = ns.prefetch

credentials = pika.PlainCredentials("guest", "guest")
parameters = pika.ConnectionParameters(
    host="localhost",
    port=rmq_port,
    virtual_host=vhost,
    credentials=credentials,
)
connection = pika.BlockingConnection(parameters)
channel = connection.channel()
channel.basic_qos(prefetch_count=prefetch)


def on_message(ch, method_frame, _header_frame, body):
    delivery_tag = method_frame.delivery_tag
    if delivery_tag % log_every == 0:
        logger.info("consumed message: %d %s", delivery_tag, body)
    ch.basic_ack(delivery_tag)


channel.basic_consume(on_message_callback=on_message, queue="inventory-fed")

try:
    channel.start_consuming()
except KeyboardInterrupt:
    channel.stop_consuming()

connection.close()
