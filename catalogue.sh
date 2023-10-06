#!/bin/bash

DATE=$(date +%F)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log

VALIDATE(){
if [ $1 -ne 0 ]
then
    echo " $2 .... failure"
    exit 1
else     
    echo " $2 .... success"
fi  
}

USERID=$( id -u )
if [ $USERID -ne 0 ]
then 
   echo "ERROR: run wid root access"
   exit 1
fi
yum install nodejs -y
useradd roboshop
mkdir /appunzip /tmp/catalogue.zip
npm install 
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
yum install mongodb-org-shell -y
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js

