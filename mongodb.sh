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
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOGFILE
VALIDATE $? "copying repo file"

yum install mongodb-org -y &>>LOGFILE
VALIDATE $? "installing mongodb"

systemctl enable mongod &>>LOGFILE
VALIDATE $? "enabling mongod"

systemctl start mongod &>>LOGFILE
VALIDATE $? "starting momgod"

sed -i 's/127.0.0.1/0.0.0.0' /etc/mongod.conf 
VALIDATE $? "edited conf"

systemctl restart mongod &>>LOGFILE
VALIDATE $? "restarting momgod"