#!/bin/bash
#sleep 15
#Load Environment
source $HOME/.profile;

coreDir=/home/brett/git/team-core-dev/app-core

cd $coreDir; 
docker-compose kill; 
docker-compose rm -v -f; 
docker-compose build --force-rm --pull;
docker-compose up -d;
#sleep 15;
mvn clean
mvn package smartsheet:tomcat-undeploy dbbuilder:buildmysql --projects schema;
mvn package smartsheet:tomcat-deploy --projects dev2 -Dmaven.test.skip=true;