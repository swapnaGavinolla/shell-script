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
yum install nginx -y &>>LOGFILE
VALIDATE $? "installing nginx"
systemctl enable nginx &>>LOGFILE
VALIDATE $? "enabling nginx "
systemctl start nginx&>>LOGFILE
VALIDATE $? "starting nginx "
rm -rf /usr/share/nginx/html/*&>>LOGFILE
VALIDATE $? "removing default content "
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip&>>LOGFILE
VALIDATE $? "downloading frontend data "
cd /usr/share/nginx/html&>>LOGFILE
unzip /tmp/web.zip&>>LOGFILE
VALIDATE $? "unzipping"
