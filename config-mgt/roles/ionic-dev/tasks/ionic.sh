
REPO_NAME='ionic-learning-box'
GIT_REPO_URL="https://github.com/bwnyasse/$REPO_NAME.git"
GIT_BRANCH='master'

DOCKER_IMAGE='bwnyasse/android-cordova-ionic-dev'
CONTAINER_NAME='ionic_dev_container'
ACTION='serve'
SHA1="209285c824fc1e51175935065c785c4f0b4fbd15"


gitCheckoutSha() {
    cd $REPO_NAME
    git pull
    git reset --hard $SHA1
    cd -
}

#                       _            
#                      (_)           
#  _ .--..--.   ,--.   __   _ .--.   
# [ `.-. .-. | `'_\ : [  | [ `.-. |  
#  | | | | | | // | |, | |  | | | |  
# [___||__||__]\'-;__/[___][___||__] 
                                   
docker stop $CONTAINER_NAME || true && docker rm $CONTAINER_NAME || true

if [[ -d $REPO_NAME ]]; then 
    gitCheckoutSha
else 
    git clone $GIT_REPO_URL 
    gitCheckoutSha
fi


cd $REPO_NAME/ionic-app 

docker run --name $CONTAINER_NAME \
            -d \
            -p 9999:8100 \
            -v $PWD:/src \
            $DOCKER_IMAGE ionic-dev.sh $ACTION


