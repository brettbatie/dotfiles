#!/bin/bash
#sleep 15
#Load Environment
source $HOME/.profile;

coreDir=/home/brett/git/team-core-dev/app-connectors

cd $coreDir; 
docker-compose kill; 
docker-compose rm -v -f; 
docker-compose build --force-rm --pull;
docker-compose up -d;
#sleep 15;
#mvn clean package dbbuilder:buildmysql tomcat7:deploy
#mvn package smartsheet:tomcat-deploy --projects dev2 -Dmaven.test.skip=true;
