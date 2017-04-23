#!/bin/bash
#
################################################################################
# @description  : Entry point for ionic dev process
# @author       : bwnyasse
################################################################################

source ionic-dev-log.sh
source ionic-dev-build.sh

usage() {
   cat <<-EOF

   usage: ./ionic-dev [server|build]


   OPTIONS:
   ========
        serve      Serve the application by calling : ionic server
        build      Build the application by generating the .apk
        -h|help    Display the help

   EXEMPLE:
   ========
       ./ionic-dev serve

EOF
}


## ----
## Serve application with HTTP
##
serve_app() {
    cd /src
    npm install
    ionic serve -l #By default rendered in all mobile platform with `-l` option
}

## ---
## Call the application build process
##
build_app() {

    ionicdevbuild::performBuild
}


#                       _            
#                      (_)           
#  _ .--..--.   ,--.   __   _ .--.   
# [ `.-. .-. | `'_\ : [  | [ `.-. |  
#  | | | | | | // | |, | |  | | | |  
# [___||__||__]\'-;__/[___][___||__] 


# Read the input option
INPUT_OPTION="${1}"

case $INPUT_OPTION in

    serve)
        serve_app
        ;;
    build)
        build_app
        ;;
    *|-h|help)
        usage
        exit 1
        ;;
esac                                   