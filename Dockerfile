FROM registry.cn-shanghai.aliyuncs.com/wikifx/base:alpine-glibc-nodejs

ENV PATH="/soft/node_modules/hexo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

WORKDIR /

COPY soft soft

RUN sed -i s#/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin#/soft/node_modules/hexo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin#g /etc/profile &&\
chmod 777 -R /soft/node_modules/hexo/bin &&\
apk add --no-cache git &&\
apk add --no-cache openssh-client &&\
mkdir /root/.ssh/ &&\
chmod 700 /root/.ssh &&\
git config --global user.name "bingdang" &&\
git config --global user.email "431965560@qq.com"

COPY ssh/ /root/.ssh/

RUN chmod 600 /root/.ssh/*

WORKDIR /app

CMD ["hexo","server","-p","80"]

#docker build -t cakepanit:v3.0 -f ./Dockerfile .

#for windows
#docker run -v D:\site\app:/app -p 80:80 -d --name cakepanit cakepanit:v4.0 

#for mac
#docker run -v /Volumes/data/cakepan/app:/app -p 80:80 -d --name cakepanit40 cakepanit:v4.0 

#发版
#hexo clean
#hexo g
#hexo deploy