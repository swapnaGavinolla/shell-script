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
yum install git -y &>>LOGFILE
VALIDATE $? "installing git" 
yum install nginx -y &>>LOGFILE
VALIDATE $? "installing nginx" 
yum install postfix -y  &>>LOGFILE 
VALIDATE $? "installing postfix" 