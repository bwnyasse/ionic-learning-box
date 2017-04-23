#!/bin/bash
#
################################################################################
# @description  : Script used to launch ionic serve with docker
# @author       : bwnyasse
################################################################################

DOCKER_IMAGE='bwnyasse/android-cordova-ionic-dev'

#                       _            
#                      (_)           
#  _ .--..--.   ,--.   __   _ .--.   
# [ `.-. .-. | `'_\ : [  | [ `.-. |  
#  | | | | | | // | |, | |  | | | |  
# [___||__||__]\'-;__/[___][___||__] 
#
#

docker run  -it --rm \
            -v $PWD:/src \
            $DOCKER_IMAGE ionic-dev.sh build
