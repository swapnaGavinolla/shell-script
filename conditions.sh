#!/bin/bash
USERNAME=$(id -u)
if ($USERNAME ne 0)
then 
    echo "exit and run with root access"
    exit 1
fi
yum install mysql -y     