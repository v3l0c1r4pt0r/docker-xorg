# docker-xorg

Run graphical applications using Xorg inside docker container

# Features

- share workspace directory with host
- optionally disable internet for apps
- run chosen command at startup

# Usage

1. Build once with `make build`
2. Start with `make run DESTDIR=/location/of/workspace/on/host`
3. Optionally start with `make run CMD=/your/command
DESTDIR=/location/of/workspace/on/host` to choose command different than default
4. Attach to same container multiple times with `make attach`
