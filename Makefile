all:
	rabbitmq-plugins enable rabbitmq_federation rabbitmq_federation_management
	rabbitmqctl import_definitions local-defs.json
	@echo "****************************"
	@echo "open three terminals and run"
	@echo "python ./pika/consume.py --vhost vhost1"
	@echo "python ./pika/consume.py --vhost vhost2"
	@echo "python ./pika/publish.py --interval=0 --msgcount=10000000 -v vhost0"
	@echo "****************************"
