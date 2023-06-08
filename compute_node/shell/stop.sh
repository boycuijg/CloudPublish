#!/bin/bash

workpath=$(cd $(dirname $0) && pwd)
cd $workpath

. ../conf/core.conf

node_file=${workpath}/../node

process_num=`ps -ef |grep -v grep |grep "${node_file}\b" | wc -l`
if [ ${process_num} -ne 0 ]
then
    pids=`ps -ef |grep -v grep |grep "${node_file}\b" |awk '{print $2}'`
    for pid in $pids
    do
        kill -10 $pid
    done
fi

echo "wait node process exit"
for((i=0; i<10; i++));
do
    process_num=`ps -ef |grep -v grep |grep "${node_file}\b" | wc -l`
    if [ ${process_num} -eq 0 ]
    then
        break
    fi

    echo -n "."
    sleep 1
done

if [ ${process_num} -ne 0 ]
then
    pids=`ps -ef |grep -v grep |grep "${node_file}\b" |awk '{print $2}'`
    for pid in $pids
    do
        kill -9 $pid
    done
fi

echo -e "\n${node_file} stop ok!"
