#!/bin/bash
#警告！仅在Ubuntu20.04LTS版本进行过测试可以运行，故不能保证在centos，debian，Raspberry Pi OS，red hat等系统上运行
#警告！仅在x86平台进行测试，故不能保证在arm等平台正常运行
#警告！严重依赖ql2.8,bash解释器,grep,awk,sed,cd,pwd,echo!!! crontab可有可无
#警告！shell放到config目录
#注意！传递参数要定位的log文件夹
loacl_GPS_log=$1

shell_path=$(cd `dirname $0`; pwd)
cd $shell_path
Nowlog=`ls ../log/$loacl_GPS_log/*.log | grep $(date "+%Y\-%m\-%d")`
place=${Nowlog}
echo ${place}
sharecodemoF=`grep '^【京东账号' ${place}`
sharecodemoS=`echo $sharecodemoF |awk -F '【|】' '{for(a=1;a<=NF;a++){print $a;}}'`
sharecodemoT=`echo ${sharecodemoS} | sed 's/ /\n/g' | sed -n 'n;p'`
rescode=`echo ${sharecodemoT} |  sed 's/ /\&/g'`
echo ${rescode}
