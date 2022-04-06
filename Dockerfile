FROM ubuntu:focal
MAINTAINER Vincent Mele <vince@nyseion.com>

ENV ROCKSDB_VERSION="v7.0.4"

ENV TZ="Europe/London"
RUN apt-get update && apt-get install -yq tzdata && dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y build-essential cmake autoconf libjemalloc-dev git wget

ADD build.sh /

WORKDIR /
RUN sh /build.sh

FROM ubuntu:focal
ENV ARDB_HOME="/"
COPY --from=0 /ardb/src/ardb-server /ardb-server
COPY --from=0 /ardb/ardb.conf /ardb.conf
EXPOSE 16379

CMD ["ardb-server", "ardb.conf"]
