#!/bin/sh
#grasp web info
filename="$1"
proxys="$2"
name=$filename
base="http://www.amazon.com/dp/"
end='/'
split='	'
url_name=$base$name$end
if [ "$proxys" = "empty" ];then
	curl -i $url_name -s
else
	curl -i $url_name -s --socks5 $proxys
fi

