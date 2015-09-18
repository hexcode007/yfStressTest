#!/bin/bash
if [ $# -lt 4 ]; then
    echo $"Usage: $0 sql  pernum testnum db"
    exit 1;
fi

#测试URL
sql=$1
#每次并发个数
testnum=$3
#并发多少次
pernum=$2
#db
db=$4

echo "start:" `date +%s` >timelist.txt
echo "" > time.txt
for((j=0;j<$testnum;j++));do
{   
    for ((i=0;i<$pernum;i++));do
    {
	time=`date +%N`
	sql=${sql/where/where $time=$time and}
 	
        sql=${sql/WHERE/WHERE $time=$time and}
        start=`date +%s%N`
   	echo "start{$j}_{$i}: "`date +%s,%N`  >>timelist.txt;
        mysql -hxx.xx.xx.xx -P3308 -uxxxxxxxxx -pxxxxxxxx $db  -e "$sql"
	end=`date +%s%N`
	echo "stop{$j}_{$i}: "`date +%s,%N`  >>timelist.txt;
        echo "time:"$[$end-$start]>>time.txt;
        
    } & 
    done
    wait
}
done

wait
cat time.txt
