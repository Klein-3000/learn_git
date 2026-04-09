FROM alpine

ENV MYNAME='container-alpine'
WORKDIR /opt

COPY dockerfile.tar.gz .
ADD dockerfile.tar.gz .
COPY *file /root

# `--no-cache` 避免保留索引缓存，减小镜像体积
# apk 默认不需要`-y`
RUN apk --no-cache add vim 
CMD ["tail", "-f",  "/dev/null"]


