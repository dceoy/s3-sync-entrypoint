FROM ubuntu:24.10

ENV DEBIAN_FRONTEND noninteractive

ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip /tmp/awscli.zip
ADD s3-sync-entrypoint /usr/local/bin/s3-sync-entrypoint

RUN set -e \
      && ln -sf bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        unzip \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN set -e \
      && cd /tmp \
      && unzip awscli.zip \
      && ./aws/install

ENV INPUT_DATA_DIR /input
ENV OUTPUT_DATA_DIR /output

RUN set -e \
      && mkdir "${INPUT_DATA_DIR}" "${OUTPUT_DATA_DIR}" \
      && chmod +x /usr/local/bin/s3-sync-entrypoint

ENTRYPOINT ["/usr/local/bin/s3-sync-entrypoint"]
