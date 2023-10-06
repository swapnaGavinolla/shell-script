#!/bin/bash

DATE=$(date +%F)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log

VALIDATE(){
if [ $1 -ne 0 ]
then
    echo " $2 installation is .... failure"
    exit 1
else     
    echo " $2 installation is .... success"
fi  
}

USERID=$( id -u )
if [ $USERID -ne 0 ]
then 
   echo "ERROR: run wid root access"
   exit 1
fi
yum install git -y 
VALIDATE $? "installing git" &>>LOGFILE
yum install nginx -y
VALIDATE $? "installing nginx" &>>LOGFILE
yum install postfix -y   
VALIDATE $? "installing postfix" &>>LOGFILE