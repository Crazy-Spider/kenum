#!/bin/bash


# This is a cyber security tool good for enumeration
# The tool scans for subdomain of any domain you enter.
# It is required that you have OWASP Amass and assetfinder installed.
# Written by Jonathan Coker
# Version 1.02


url=$1

if [ ! -d "$url" ];then
	mkdir $url
fi

echo "Please wait while we search for subdomain of " $url " for you"
assetfinder $url >> $url/sub.txt

cat $url/sub.txt | grep $1 | sort -u >> $url/finalsub.txt

rm $url/sub.txt

amass enum -d $url >> $url/amasssub.txt
cat $url/amasssub.txt | sort -u >> $url/finalsub.txt
sort -u $url/finalsub.txt >> subdomains.txt
rm $url/amasssub.txt
rm $url/finalsub.txt

echo "Your search is done "
echo "Your subdomain are in the directory "$url"/finalsub.txt"
