ARG RABBITMQ_DOCKER_TAG=3-management
FROM rabbitmq:${RABBITMQ_DOCKER_TAG}

COPY --chown=rabbitmq:rabbitmq --chmod=0400 erlang.cookie /var/lib/rabbitmq/.erlang.cookie
COPY --chown=rabbitmq:rabbitmq enabled_plugins /etc/rabbitmq/
COPY --chown=rabbitmq:rabbitmq rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY --chown=rabbitmq:rabbitmq advanced.config /etc/rabbitmq/advanced.config
COPY --chown=rabbitmq:rabbitmq definitions.json /etc/rabbitmq/definitions.json

EXPOSE 4369 5672 15672 15692 25672 35672-35682
