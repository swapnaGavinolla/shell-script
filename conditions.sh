#!/bin/bash
USERNAME=$(id -u)
if ($USERNAME ne 0)
then 
    echo "exit and run with root access"
    exit 1
fi
yum install mysql -y    
if [$? ne 0]
then 
    echo "installation of mysql is error"
    exit 1
else
    echo "installation of mysql is success"
fi        