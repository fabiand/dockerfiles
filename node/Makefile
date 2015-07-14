
build: Dockerfile
	docker build -t docker.io/fabiand/node:latest .

d.%: build
	$(shell sed -n "/LABEL $* docker/ s/LABEL $*// p" Dockerfile)
