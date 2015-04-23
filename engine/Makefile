
build:
	docker build -t docker.io/fabiand/centos7-engine:latest .

run:
	$(shell sed -n "/LABEL run/ s/LABEL run// p" Dockerfile)
