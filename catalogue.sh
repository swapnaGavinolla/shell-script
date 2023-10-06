#!/bin/bash

DATE=$(date +%F)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
if [ $1 -ne 0 ]
then
    echo -e " $2 .... $R failure $N"
    exit 1
else     
    echo -e " $2 .... $G success$N"
fi  
}

USERID=$( id -u )
if [ $USERID -ne 0 ]
then 
   echo "ERROR: run wid root access"
   exit 1
fi

curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>LOGFILE
VALIDATE $? "downloading setup"

yum install nodejs -y &>>LOGFILE
VALIDATE $? "installing nodeJS"

useradd roboshop &>>LOGFILE
VALIDATE $? "adding user"

mkdir /app &>>LOGFILE
VALIDATE $? "creating directory"
 
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip 
VALIDATE $? "downloading the application code"

cd /app &>>LOGFILE

unzip /tmp/catalogue.zip &>>LOGFILE
VALIDATE $? "unzipping"

cd /app &>>LOGFILE

npm install &>>LOGFILE
VALIDATE $? "installing npm"

cp /home/centos/shell-script/catalogue.service   /etc/systemd/system/catalogue.service &>>LOGFILE
VALIDATE $? "copying repo"

systemctl daemon-reload &>>LOGFILE
VALIDATE $? "demon reloading"

systemctl enable catalogue &>>LOGFILE
VALIDATE $? "enabling catalogue"

systemctl start catalogue &>>LOGFILE
VALIDATE $? " starting catalogue"

cp /home/centos/shell-script/catalogue.service /etc/yum.repos.d/mongo.repo
VALIDATE $? "copying repo"

yum install mongodb-org-shell -y &>>LOGFILE
VALIDATE $? "installing mongo client"

mongo --host 172.31.41.224 </app/schema/catalogue.js &>>LOGFILE
VALIDATE $? " loading schema"

