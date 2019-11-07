#!/bin/sh

serverIp=47.92.38.164
eurekaUrl=http://${serverIp}:5001
configPort=5003
adminPort=5004
protalPort=5005

# apollo config db info
apollo_config_db_url=jdbc:mysql://${serverIp}:5002/ApolloConfigDB?characterEncoding=utf8
apollo_config_db_username=root
apollo_config_db_password=CrazyAndyIsFine.007

# apollo portal db info
apollo_portal_db_url=jdbc:mysql://${serverIp}:5002/ApolloPortalDB?characterEncoding=utf8
apollo_portal_db_username=root
apollo_portal_db_password=CrazyAndyIsFine.007

# meta server url, different environments should have different meta server addresses
dev_meta=http://${serverIp}:${configPort}
fat_meta=http://${serverIp}:${configPort}
uat_meta=http://${serverIp}:${configPort}
pro_meta=http://${serverIp}:${configPort}

META_SERVERS_OPTS="-Ddev_meta=$dev_meta -Dfat_meta=$fat_meta -Duat_meta=$uat_meta -Dpro_meta=$pro_meta"

# =============== Please do not modify the following content =============== #
# go to script directory
cd "${0%/*}"

cd ..

# package config-service and admin-service
echo "==== starting to build config-service and admin-service ===="

mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=$apollo_config_db_url -Dspring_datasource_username=$apollo_config_db_username -Dspring_datasource_password=$apollo_config_db_password -DserverIp=$serverIp -DeurekaUrl=$eurekaUrl -DconfigPort=$configPort -DadminPort=$adminPort

echo "==== building config-service and admin-service finished ===="

echo "==== starting to build portal ===="

mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth -Dspring_datasource_url=$apollo_portal_db_url -Dspring_datasource_username=$apollo_portal_db_username -Dspring_datasource_password=$apollo_portal_db_password $META_SERVERS_OPTS

echo "==== building portal finished ===="

pwd

cp -rf apollo-configservice/target/apollo-configservice-1.6.0-SNAPSHOT.jar ../docker-scripts/apollo/service/config/

cp -rf apollo-adminservice/target/apollo-adminservice-1.6.0-SNAPSHOT.jar ../docker-scripts/apollo/service/admin/

cp -rf apollo-portal/target/apollo-portal-1.6.0-SNAPSHOT.jar ../docker-scripts/apollo/service/portal/

echo "==== copy config,admin,portal jars finished ===="

