mkdir -p /data/mongo-db && chmod 777 /data/mongo-db

docker network create nd-iot-edge 

docker run -d -p 27017:27017  --network nd-iot-edge --name mongodb      -v /data/mongo-db:/data/db mongo:latest

docker run -d -p 80:8080      --network nd-iot-edge --name nd-iot-edge  -e IOT_CODE_BRANCH=dev -e IOT_ENABLE_AUTO_UPDATE=0  -e IOT_ENABLE_NGINX=1  -e IOT_ENABLE_MQTT=1 -e IOT_ENABLE_EDG=1 -e IOT_APP_ID=ndiot -e IOT_EDG_ID=ndiot-edg-test nd-iot-edge:21

docker update --restart=always mongodb
docker update --restart=always nd-iot-edge