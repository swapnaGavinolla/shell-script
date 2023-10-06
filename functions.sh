#!/bin/bash
USERID=$(id -u)
if[$USERID -ne 0]
then 
   echo "ERROR: run wid root access"
   exit 1
fi
yum install git -y 
VALIDATE $? "installing git"
yum install nginx -y
VALIDATE $? "installing nginx"
yum install postfix -y   
VALIDATE $? "installing postfix"