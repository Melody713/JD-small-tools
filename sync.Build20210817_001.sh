#!/bin bash
#$1=GitHubID $2=Code Address $3=Storage location, you can leave it blank
GitHubname=$1
GitHubAddress=$2
StorageLocation=$3
#搞颜色
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
#当前时间
NowTime=$(date "+%Y%m%d-%H%M%S")
#输出当前时间
echo "${NowTime}"
#检查$ 参数
 if [ -z $GitHubname ];then 
    echo -e "${red}ERR!${none} GitHubname empty!" && exit 1	
 else
    echo -e "${green}OK!${none} GitHubname: $GitHubname"
	if [ -z $GitHubAddress ];then
	   echo -e "${red}ERR!${none} GitHubAddress empty!" && exit 1
	else
	   echo -e "${green}OK!${none} GitHubAddress: $GitHubAddress"
	fi	
 fi
 #检测是否启用本地存储位置，没有就用启用默认位置
if [ -z $StorageLocation ];then
    echo -e "${yellow}Empty!${none} Enable default location: $(pwd)"
	StorageLocation=$(pwd)
else
    echo -e "Storage Location: $StorageLocation"
fi
#判断系统的软件包管理器函数
function_SetUpDataCommand() {
cmd="apt-get"
     if [[ $(command -v apt-get) || $(command -v yum) ]]; then
	      if [[ $(command -v yum) ]]; then
		     cmd="yum"
	      fi
     else
	     echo -e "哈哈……这个 ${red}辣鸡脚本${none} 不支持你的系统。 ${yellow}(-_-) ${none}" && exit 1
     fi
echo $cmd
}
#检测是否含有git命令，没有就自动安装
if [[ $(command -v git) ]];then
   echo -e "${green}OK!${none} command git"
else
   function_SetUpDataCommand
   $cmd update -y && $cmd install git
fi
#从地址中取项目名
address_split=`echo ${GitHubAddress} |awk -F '/' '{print $NF}'`
project=`echo ${address_split} |awk -F '.' '{print $1}'`
echo "Project name: $project"
#开始下载
git clone $GitHubAddress $StorageLocation/$GitHubname/$project/$NowTime

