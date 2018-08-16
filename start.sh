#!/usr/bin/env bash

mvn clean install -DskipTests

cd spring-petclinic-config-server
cd spring-petclinic-config-server
	echo "Starting Configuration Server"
	mvn spring-boot:run &
	cd ..

./wait-for-it.sh localhost:8888/actuator/health 60

echo "Configuration Server started"

cd spring-petclinic-discovery-server
	echo "Starting Discovery Server"
	mvn spring-boot:run &
	cd ..

./wait-for-it.sh localhost:8761/actuator/health 60

echo "Discovery Server started"

cd spring-petclinic-customers-service
echo "Starting Customers Service"
mvn spring-boot:run &
cd ..

cd spring-petclinic-vets-service
echo "Starting Vets Service"
mvn spring-boot:run &
cd ..

cd spring-petclinic-visits-service
echo "Starting Visits Service"
mvn spring-boot:run &
cd ..

cd spring-petclinic-api-gateway
echo "Starting API Gateway"
mvn spring-boot:run &
cd ..

cd spring-petclinic-tracing-server
echo "Starting Tracing Server"
mvn spring-boot:run &
cd ..

cd prometheus
echo "Starting Prometheus Server"
./start_prometheus.sh &
cd ..

echo "Started all Services"
