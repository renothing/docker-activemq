FROM openjdk:7-jre-alpine
MAINTAINER renothing 'frankdot@qq.com'
LABEL role='activemq' version='5.14.1' tags='activemq' description='activemq for message queue'
#set language enviroments                                                
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \                                
    TIMEZONE="Asia/Shanghai" \
    VERSION=5.14.1                              
#install software                                                          
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update && \ 
RUN apk update && \
#   wget http://mirrors.aliyun.com/apache/activemq/${VERSION}/apache-activemq-${VERSION}-bin.tar.gz -O /usr/local/apache-activemq-${VERSION}-bin.tar.gz && \
    wget http://archive.apache.org/dist/activemq/${VERSION}/apache-activemq-${VERSION}-bin.tar.gz -O /usr/local/apache-activemq-${VERSION}-bin.tar.gz && \
    cd /usr/local && tar xf apache-activemq-${VERSION}-bin.tar.gz && mv apache-activemq-${VERSION} apache-activemq && \
    rm -rf /usr/local/apache-activemq-${VERSION}-bin.tar.gz && \
    apk add tzdata && \
    cp -rf /usr/share/zoneinfo/"${TIMEZONE}" /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*
#export data dir
#VOLUME ["/usr/local/apache-activemq/data","/usr/local/apache-activemq/conf"]
#forwarding port
EXPOSE 8161
#set default command
ENTRYPOINT ["/usr/local/apache-activemq/bin/activemq"]
CMD ["console"]
