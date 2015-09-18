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


curl -c ck.txt --user-agent YJZMozilla/4.0 -d "username=xxxxx&password=xxxxxx"  http://system.xxxxxxx.com/site/login > /dev/null 2>&1
#先测试一次,检查内容是否正确
curl -XGET -b ck.txt --user-agent Mozilla/4.0  $1 > content.txt 2>&1
cookie=`cat ck.txt |grep PHPSESSID|awk '{print $7}'`
ab -r -n $total -c $pernum -C PHPSESSID=$cookie $url > ab.txt
cat ab.txt
