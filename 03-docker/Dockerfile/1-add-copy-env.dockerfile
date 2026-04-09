# 基础镜像
FROM alpine

# 设置工作目录
ENV MYWORKDIR=/opt
WORKDIR $MYWORKDIR

# 定义好工作目录，后面直接使用`.`即可
ADD dockerfile.tar.gz .
COPY 1-add-copy-env.dockerfile .


RUN cp cmd.dockerfile /root/

CMD ["/bin/sh", "-c", "echo 'Showing cmd.dockerfile' && cat cmd.dockerfile"]
