# Docker-Compose inside a container

[![](https://images.microbadger.com/badges/image/infrabricks/docker-compose:alpine.svg)](http://microbadger.com/images/infrabricks/docker-compose "Get your own image badge on microbadger.com")

![logo](https://raw.githubusercontent.com/infrabricks/docker-compose/master/logo.png)

This is a small docker tool wrapper for docker-compose :)

## install

```
$ git clone https://github.com/infrabricks/docker-compose
$ docker build -t infrabricks/docker-compose .
# or
$ docker pull infrabricks/docker-compose
# install the script
$ docker run --rm -v $(pwd):/data --entrypoint=/scripts/install infrabricks/docker-compose
```

Move `docker-compose` script to standard directory at your `PATH`.

## build

```
$ git clone https://github.com/infrabricks/docker-compose
$ docker build -t infrabricks/docker-compose .
# or
$ docker pull infrabricks/docker-compose
# install the script
$ docker run --rm -v /usr/local/bin:/data --entrypoint=/scripts/install infrabricks/docker-compose
```

## Usage

```
cat >docker-compose.yml <<EOF
hello:
  image: hello-world
EOF
./docker-compose up
Creating hello_hello_1...
Pulling image hello-world:latest...
31cbccb51277: Pull complete
e45a5af57b00: Pull complete
.024 kB/1.024 kBBeady exists
hello-world:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Status: Downloaded newer image for hello-world:latest
Attaching to hello_hello_1
hello_1 | Hello from Docker.
hello_1 | This message shows that your installation appears to be working correctly.
hello_1 |
hello_1 | To generate this message, Docker took the following steps:
hello_1 |  1. The Docker client contacted the Docker daemon.
hello_1 |  2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
hello_1 |     (Assuming it was not already locally available.)
hello_1 |  3. The Docker daemon created a new container from that image which runs the
hello_1 |     executable that produces the output you are currently reading.
hello_1 |  4. The Docker daemon streamed that output to the Docker client, which sent it
hello_1 |     to your terminal.
hello_1 |
hello_1 | To try something more ambitious, you can run an Ubuntu container with:
hello_1 |  $ docker run -it ubuntu bash
hello_1 |
hello_1 | For more examples and ideas, visit:
hello_1 |  http://docs.docker.com/userguide/
hello_hello_1 exited with code 0
Gracefully stopping... (press Ctrl+C again to force)
```

## Use compose to provision other machines

Access a external server with docker-compose set the
DOCKER_X Variables

```
$ $(docker-machine env dev)
$ docker run -v "$PWD:/$PWD" -v $DOCKER_CERT_PATH:/certs \
 -e DOCKER_CERT_PATH=/certs \
 -e DOCKER_HOST=$DOCKER_HOST \
 -e DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY \
 -ti --rm -w "$PWD" \
 infrabricks/docker-compose --help
```

set an alias

```

$ _docker-compose() {
  _PWD=$PWD
  docker run -v "$_PWD":"$_PWD" \
    -v $DOCKER_CERT_PATH:/certs \
    -e DOCKER_CERT_PATH=/certs \
    -e DOCKER_HOST=$DOCKER_HOST \
    -e DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY \
    -ti --rm  -w "$_PWD" \
    infrabricks/docker-compose $@
}
$ alias docker-compose="_docker_compose $@"
```

At linux normal user use this alias with correct user and group mapping

```bash
$ _docker-compose () {
  DIRNAME=$"$(basename \"$PWD\")"
  docker run --rm -it \
    -e LOCAL_USER_ID=\`id -u \$USER\`  \
    -e LOCAL_USER_GROUP_ID=\`id -g \$USER\` \
    -e LOCAL_USER_GROUP_NAME=\`id -gn \$USER\` \
    --rm \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -v "$DIRNAME":"$DIRNAME":ro \
    -w "$DIRNAME" \
    infrabricks/docker-compose:alpine \
    docker-compose "$@"
}
$ alias docker-compose="_docker_compose $@"
```

## Building other versions

If you want build a specific version of [Docker Compose](https://docs.docker.com/compose/) build your own by the following example.

```bash
$ docker build -f Dockerfile.alpine  \
 --build-arg DOCKER_COMPOSE_VERSION=1.9 \
 -t infrabricks/docker-compose:alpine-1.9 .
```

- If you don't set --build-arg it docker-compose `1.10` will be used.

Other build args

| Build ARG                | Default Value |
|:-------------------------|:--------------|
| `DOCKER_COMPOSE_VERSION` | `1.10`        |
| `GOSU_VERSION`           | `1.10`        |
| `GLIBC_VERSION`          | `2.23-r3`     |

## labels

We add some lables

* http://label-schema.org/rc1/

## Source code

* [infrabricks/docker-compose](https://github.com/infrabricks/docker-compose)

## Contact

For bugs, questions, comments, corrections, suggestions, etc., open an issue in
 [infrabricks/docker-compose](https://github.com/infrabricks/docker-compose/issues) with a title starting with `[docker-compose] `.

Or just [click here](https://github.com/infrabricks/docker-compose/issues/new?title=%5Bdocker-compose%5D%20) to create a new issue.

## License

Copyright (c) 2014-2017 [bee42 solutions Gmbh- Peter Rossbach](https://bee42.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

More details read the [project license file](https://raw.githubusercontent.com/infrabricks/docker-compose/master/LICENSE)!

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Reference

* https://github.com/docker/compose
* https://docs.docker.com/compose/
* Use old fig inside a docker container
  * https://github.com/ianblenke/docker-fig-docker
* https://github.com/docker/compose/releases/tag/1.2.0
* https://github.com/docker/compose/releases/tag/1.3.0rc1
* https://github.com/wernight/docker-compose
