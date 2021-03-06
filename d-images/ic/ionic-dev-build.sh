#!/bin/bash
#
################################################################################
# @description  : Script used to perform android build of ionic application 
# @author       : bwnyasse
################################################################################

source ionic-dev-log.sh

OUTPUT_DIR="platforms/android/build/outputs/apk"
APK_FILE_DEBUG="$OUTPUT_DIR/android-debug.apk" # The willing output  apk debug file name
APK_FILE_DEBUG_SIGNED="$OUTPUT_DIR/android-debug-signed.apk"
RELEASE_KEY="$DEV_EXTRA_RESOURCES_PATH/app.keystore"
ALIAS_KEY_NAME="androidAppKey"


## ----
##
## Method used to create mandatory directories 
## Developer must not push "plugins" & "platforms" dir into version control system 
## Using git , they must be listed into .gitignore file
##
ensureMandatoryDirectories() {
    if [[ ! -d "plugins" ]] ; then
        log_info "Creating 'plugins' directory."
        mkdir plugins
    fi

    if [[ ! -d "platforms" ]] ; then
        log_info "Creating 'platforms' directory."
        mkdir platforms
    fi
}

# ## ---
# ## 
# ## Method used to sign the .apk
# ##
# signApk() {
#         log_info "Try to sign generated apk"
#         cp $APK_FILE_DEBUG $APK_FILE_DEBUG_SIGNED
# 		jarsigner -verbose -keystore $RELEASE_KEY -storepass $SIGN_KEY_PWD -keypass $SIGN_KEY_PWD $APK_FILE_DEBUG_SIGNED $ALIAS_KEY_NAME
# 		if [ $? -ne 0 ]; then
# 			log_error_and_exit "Error while signing $APK_FILE_DEBUG !"
# 	  	fi
# }


## ----
## 
## Entry point definition
##
ionicdevbuild::performBuild() {


    # FIXME : In the following line, I assumed that the build will be performed in the root source directory
    cd /src

    echo $pwd 

    log_info "Ensure to disable cordova telemetry"
    cordova telemetry off

    ensureMandatoryDirectories

    # Prepare node modules
    npm install
    
    # Display information about current installation
    ionic info

    # --------------------------------------------------------------
    # Attempting to restore your Ionic application from package.json
    # For instance, this action will install all plugins define into package.json
    # --------------------------------------------------------------
    ionic state restore


    log_info "Add android platform ..."
    ## -------------------------------------------------------
    ## This adds a folder android within the platforms folder 
    ## in your app and adds the neccesarry resources needed 
    ## to build an android application.
    ## --------------------------------------------------------
    ionic platform add android


    log_info "Build the android app !"
    ## -------------------------------------------------------
    ## This builds the application, and puts the built apk 
    ## in the platforms/android/build/outputs folder.
    ## -------------------------------------------------------
    ionic build android

    if [[ $? -eq 0 ]]; then
        
        [[ ! -f $APK_FILE_DEBUG ]] && log_error_and_exit " Enable to find the generated .apk file"
        # signApk
        
        log_info "Done ! @see $OUTPUT_DIR to retrieve apk files" 

    else
        log_error_and_exit " Enable to generate .apk for android market"
    fi
}
