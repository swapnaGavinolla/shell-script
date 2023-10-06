#!/bin/bash
USERNAME=$(id -u)
if [$USERNAME -ne 0]
then 
    echo "exit and run with root access"
    exit 1
fi
yum install nginx -y    
if [ $? -ne 0]
then 
    echo "installation of nginx is error"
    exit 1
else
    echo "installation of nginx is success"
fi        