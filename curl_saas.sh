#!/bin/bash
#saas测试,带登录功能
if [ "$#" -ne "3" ]; then
    echo $"Usage: $0 url  pernum testnum"
    exit 1
fi


#测试URL
url=$1
#每次并发个数
testnum=$3
#并发多少次
pernum=$2


echo "start:" `date +%s` >timelist.txt
echo "" > time.txt
curl -c ck.txt --user-agent YJZMozilla/4.0 -d "username=xxx&password=xxxxx"  http://system.xxxxxx.com/site/login > /dev/null 2>&1
for((j=0;j<$testnum;j++));do
{   
    for ((i=0;i<$pernum;i++));do
    {
   	#sleep 3;
 	start=`date +%s%N`
   	echo "start{$j}_{$i}: "`date +%s,%N`  >>timelist.txt;
   	curl -XGET -L -e ';auto' -b ck.txt --user-agent Mozilla/4.0  $1 >/dev/null 2>&1
        end=`date +%s%N`
	echo "stop{$j}_{$i}: "`date +%s,%N`  >>timelist.txt;
        echo "time:"$[$end-$start]>>time.txt;
        
    } & 
    done
    wait
}
done
wait
curl -XGET -L -e ';auto' -b ck.txt --user-agent Mozilla/4.0  $1 > content.txt 2>&1
cat time.txt
