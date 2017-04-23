FROM bwnyasse/android-cordova-ionic

ENV IONIC_DEV_RESOURCES_PATH=/ionic-dev-resources

ADD ic $IONIC_DEV_RESOURCES_PATH/bin/

RUN chmod +x $IONIC_DEV_RESOURCES_PATH/bin/*.sh  

ENV PATH $IONIC_DEV_RESOURCES_PATH/bin:$PATH

CMD ["/bin/bash"]