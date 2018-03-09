#!/bin/bash

readFileIdol()
{
	count=0
	while read -r line
	do
		idolNames[$count]="$line"
		count=`expr $count + 1`
	done < Idol.txt
}

getLinkImageFromGoogle()
{
	getLink=$(wget --user-agent 'Mozilla/5.0' -qO - "www.google.com/search?q=$idolName&tbm=isch" | sed 's/</\n</g' | grep '<img' | 				head -n5 | sed 's/.*src="\([^"]*\)".*/\1/')
}

downloadImageFromGoogle()
{
	dayIndex=0
	day=$1

	readFileIdol
	for idolName in "${idolNames[@]}"
	do
      	 	 getDayOfWeek $day $dayIndex
       		 getLinkImageFromGoogle
       		 wget $getLink -P /home/thang/ShellScript/Result/$date
     		 dayIndex=`expr $dayIndex + 1`
	done

}

getDayOfWeek()
{	
	day=$1
	dayIndex=$2
	date=`date +%F -d "$day -$(date -d $day +%u) days + $dayIndex day"`
}

#Main
echo -n "Enter a day(yyyy-mm-dd): "
read day

downloadImageFromGoogle $day
