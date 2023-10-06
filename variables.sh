#!/bin/bash

#1.declaring inside d script

a=100
b=200
c=$((a+b))
echo "the sum is $c"

#2.run d command inside n store d output in variable

DATE=$(date)
echo "this is done at $DATE"

#3.can get d values from command line
name1=$3
name2=$4
echo "given names are $name1 and $name2"

#4.get username n password --prompt d user to enter
echo "enter ur username"
read USERNAME
echo "u entered d username as $USERNAME"
echo "enter ur password"
read PASSWORD
echo "u entered d username as $PASSWORD"


