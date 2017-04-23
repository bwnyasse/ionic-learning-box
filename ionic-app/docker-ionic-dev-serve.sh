#!/bin/bash
#
################################################################################
# @description  : Script used to launch ionic serve with docker
# @author       : bwnyasse
################################################################################

DOCKER_IMAGE='bwnyasse/android-cordova-ionic-dev'
CONTAINER_NAME='ionic_dev_container'
ACTION='serve'


#                       _            
#                      (_)           
#  _ .--..--.   ,--.   __   _ .--.   
# [ `.-. .-. | `'_\ : [  | [ `.-. |  
#  | | | | | | // | |, | |  | | | |  
# [___||__||__]\'-;__/[___][___||__] 
#
#

if [[  "$(docker ps -q -f name=$CONTAINER_NAME)" ]]; then
    docker stop $CONTAINER_NAME
fi

docker run --name $CONTAINER_NAME \
            -d \
            -p 9999:8100 \
            -v $PWD:/src \
            $DOCKER_IMAGE ionic-dev.sh $ACTION