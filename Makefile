DESTDIR=
NAME=docker-xorg
CMD=/bin/xterm
UID=$(shell id -u)
GID=$(shell id -g)

all: build run

build:
	docker build --build-arg=uid=$(UID) --build-arg=gid=$(GID) -t $(NAME) .

run:
	xauth nlist :0 | sed -e 's/^..../ffff/' | head -1 | xauth nmerge -
	@test -n "$(DESTDIR)" || (echo Error: You have to specify DESTDIR && false)
	mkdir -p $(DESTDIR)
	docker run -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v $(DESTDIR):/home/admin/workspace -v /dev/bus/usb:/dev/bus/usb -v /run/user/1000/at-spi/bus_0:/run/user/1000/at-spi/bus_0 -e DISPLAY=:0 -e XAUTH="$$(xauth nlist :0 | grep ^ffff)" -e CMD="$(CMD)" --privileged --name $(NAME) $(NAME):latest

attach:
	docker exec -it $(NAME) bash
