@echo off

echo "Checking conf\import ..."
if not exist .\conf\import\ (
    echo "conf\import not present"
    xcopy /E .\conf\import-tmpl\ .\conf\import\

    xcopy .\tools\docker\asset\char_conf.txt .\conf\import\
    xcopy .\tools\docker\asset\inter_conf.txt .\conf\import\
    xcopy .\tools\docker\asset\map_conf.txt .\conf\import\
)

echo "Checking conf\msg_conf\import ..."
if not exist .\conf\msg_conf\import\ (
    echo "conf\msg_conf\import not present"
    xcopy /E .\conf\msg_conf\import-tmpl\ .\conf\msg_conf\import\
)

echo "Checking db\import ..."
if not exist .\db\import\ (
    echo "db\import not present"
    xcopy /E .\db\import-tmpl\ .\db\import\
)

