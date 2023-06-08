#!/bin/bash

workpath=$(cd $(dirname $0) && pwd)
cd $workpath

. ../conf/core.conf

node_file=${workpath}/../node

process_num=`ps -ef | grep -v grep | grep "${node_file}\b" | wc -l`
if [ ${process_num} -ne 0 ]
then
    echo "${node_file} is already running!"
    exit 1
else
    host=$(hostname)
    ${node_file} --compute -d -n $host
fi

process_num=`ps -ef | grep -v grep | grep  "${node_file}\b" | wc -l`
if [ ${process_num} -eq 0 ]
then
    echo "${node_file} start failed!"
    exit 1
fi

echo "${node_file} start ok!"
