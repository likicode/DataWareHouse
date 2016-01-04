#!/bin/sh
filename="$1"
while read -r line
do
	        name=$line
	        echo "Name read from file - $name"
	    	base="http://www.amazon.com/dp/"
		end='/'
		split='	'
		url_name=$base$name$end
		a=0
		while [ $a -lt 15 ]; do
    			wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue $url_name
  		       if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
		       a=`expr $a + 1`
		done;
		mv index.html $name
		mv -t /home/liki/old/warehouse/newly_crawl $name
done < "$filename"
