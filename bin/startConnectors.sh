#!/bin/bash
#sleep 15
#Load Environment
source $HOME/.profile;

coreDir=/home/brett/git/team-core-dev/app-connectors

cd $coreDir;
docker-compose up -d;
docker-compose logs;