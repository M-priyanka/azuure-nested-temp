#! /bin/bash

count=1001
while [ $count -le 1003 ]
do
   jsonfile=`python getdata.py $count`
   echo $jsonfile >> inputparam-$count.json
   count=`expr $count + 1`
done
