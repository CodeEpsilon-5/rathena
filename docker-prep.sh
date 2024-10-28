#!/bin/sh

echo Checking conf/import ...
if [ ! -d "./conf/import" ]; then
    echo conf/import not present
    cp -r ./conf/import-tmpl ./conf/import/
    # Copy additional docker-specific configurations
    cp ./tools/docker/asset/* ./conf/import/
fi

echo Checking conf/msg_conf/import ...
if [ ! -d "./conf/msg_conf/import" ]; then
    echo conf/msg_conf/import not present
    cp -r ./conf/msg_conf/import-tmpl ./conf/msg_conf/import/
fi

echo Checking db/import ...
if [ ! -d "./db/import" ]; then
    echo db/import not present
    cp -r ./db/import-tmpl ./db/import/
fi
