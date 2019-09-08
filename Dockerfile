FROM alpine:3.10

RUN apk add --no-cache --update \
    gettext \
    nginx \
    alpine-sdk \
    curl \
    python3 \
    python3-dev \
    py3-pip \
    supervisor \
    git && \
    mkdir -p /var/cache/nginx 

RUN apk add --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing\
    php7-pecl-mongodb && \
    cd /tmp; wget http://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/redis-5.0.5-r0.apk; apk add --allow-untrusted redis-5.0.5-r0.apk; rm -rf redis-5.0.5-r0.apk && \
    rm -rf /tmp/*


# redis server
RUN cd /tmp; wget http://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/redis-5.0.5-r0.apk; apk add --allow-untrusted redis-5.0.5-r0.apk; rm -rf redis-5.0.5-r0.apk && \
    rm -rf /tmp/*


RUN apk add --update --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    gflags
RUN apk add --update --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    rocksdb \
    rocksdb-dev \
    snappy \
    zlib \
    bzip2 \
    leveldb \
    leveldb-dev
    
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
#RUN apk add py3-zmq
RUN pip3 install faster-than-requests

WORKDIR /home

COPY . /home
COPY conf/supervisord.conf /etc/supervisord.conf

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
