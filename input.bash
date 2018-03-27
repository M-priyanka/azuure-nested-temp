#! /bin/bash

count=1003
while [ $count -le 1005 ]
do
   jsonfile=`python getdata.py $count`
   echo $jsonfile >> inputparam-$count.json
   count=`expr $count + 1`
done
