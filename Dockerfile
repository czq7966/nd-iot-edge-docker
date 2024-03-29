FROM koenkk/zigbee2mqtt:1.22.0

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories 

RUN apk add --no-cache --virtual .buildtools sudo tzdata eudev tini zlib-dev pcre-dev make gcc g++ python3 linux-headers git shadow 

RUN rm -f /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && mkdir -p /home/iot \
    && addgroup iot \
    && adduser -D -G iot -h /home/iot -u 8080 iot  \
    && chown -R iot:iot /home/iot \
    && mkdir -p /services \
    && mkdir -p /data \
    && mkdir -p /data/db \
    && mv /app /services/zigbee2mqtt \
    && chown -R iot:iot /services \
    && chown -R iot:iot /data \
    && chmod 777 -R /data/db \
    && echo "iot    ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "%sudo  ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "root:123456" | chpasswd 

USER iot     

RUN cd /services \
    && wget http://nginx.org/download/nginx-1.22.0.tar.gz   \
    && tar -xvf nginx-1.22.0.tar.gz \
    && cd /services/nginx-1.22.0 \
    && ./configure && make && sudo make install
COPY ./nginx/conf/. /usr/local/nginx/conf/.    

RUN mkdir -p /services \
    &&  cd /services \
    &&  git clone https://github.com/czq7966/nd-iot-mqtt-broker.git nd-iot-mqtt-broker -b dev \
    &&  cd /services/nd-iot-mqtt-broker \
    &&  npm install   


RUN mkdir -p /services \
    &&  cd /services \
    &&  cd /services \
    &&  cd /services \
    &&  cd /services \
    &&  cd /services \
    &&  cd /services \
    &&  cd /services \    
    &&  cd /services \    
    &&  cd /services \   
    &&  cd /services \
    &&  cd /services \
    &&  cd /services \
    &&  cd /services \    
    &&  git clone https://github.com/czq7966/nd-iot-edge.git nd-iot-edge -b dev \
    &&  cd /services/nd-iot-edge \
    &&  npm run nd:install \
    &&  cd /services/nd-iot-edge    

COPY ./nd-iot-edge/start.sh /services/nd-iot-edge/.  
RUN sudo chmod 777 /services/nd-iot-edge/start.sh

WORKDIR /services/nd-iot-edge

EXPOSE 1880-1884 8080-8090 18090-18199 11880-11889 27017
USER iot
ENTRYPOINT []
CMD ["/services/nd-iot-edge/start.sh"]