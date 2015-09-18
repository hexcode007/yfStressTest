#!/bin/bash
#saas测试,带登录功能
if [ $# -lt 3 ]; then
    echo $"Usage: $0 url  pernum testnum"
    exit 1;
fi

#测试URL
url=$1
#每次并发个数
total=$[$3*$2]
#并发多少次
pernum=$2
#请求参数
post=${4:-""}


echo $post>post.text
ab -r -n $total -c $pernum -p post.text  $url > ab.text
cat ab.text
