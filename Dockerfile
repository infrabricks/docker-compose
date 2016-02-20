FROM debian:8
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach

ARG DOCKER_COMPOSE_VERSION
ENV DOCKER_COMPOSE_VERSION ${DOCKER_COMPOSE_VERSION:-1.6.0}
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends curl ca-certificates  \
 && curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` >/usr/local/bin/docker-compose ; chmod +x /usr/local/bin/docker-compose \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD LICENSE /etc/LICENSE.compose
ADD docker-compose /scripts/docker-compose
ADD install /scripts/install

RUN COPYDATE=`date  +'%Y'` \
 && echo "infrabricks docker-compose" >/etc/provisioned.compose \
 && date >>/etc/provisioned.compose \
 && echo >>/etc/provisioned.compose \
 && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.compose

WORKDIR /project
ENTRYPOINT [ "/usr/local/bin/docker-compose" ]
CMD [ "" ]
