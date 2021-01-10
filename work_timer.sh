#!/bin/bash

echo -e "\033[37;44;1;82m####################\033[0m"
echo -e "\033[37;44;1;82m###  Work Timer  ###\033[0m"
echo -e "\033[37;44;1;82m####################\033[0m"
echo -e "\033[37;44;1;82m#\033[0m                  \033[37;44;1;82m#\033[0m"

time=$(zenity --forms --title="Work Timer" --text="Enter working time\n\nEx.  Hours: 1   |   Minutes: 30" \--add-entry="Hours" \--add-entry="Minutes")
h=$(echo $time | cut -d '|' -f1)
m=$(echo $time | cut -d '|' -f2)

if [[ $h != ?(-)+([0-9]) ]] >/dev/null 2>&1
then
  h=0
fi

if [[ $m != ?(-)+([0-9]) ]] >/dev/null 2>&1
then
  m=0
fi

if [ $h -le 9 ] && [ $m -le 9 ] >/dev/null 2>&1
then
  echo -e "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: 0$h:0$m:00\033[0m  \033[37;44;1;82m#\033[0m"
  echo -e "\033[37;44;1;82m#\033[0m                  \033[37;44;1;82m#\033[0m"
  echo -e "\033[37;44;1;82m####################\033[0m"
  echo -e "\033[37;44;1;82m###  Working...  ###\033[0m"
  echo -e "\033[37;44;1;82m####################\033[0m"
elif [ $h -le 9 ]
then    
  echo -e "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: 0$h:$m:00\033[0m  \033[37;44;1;82m#\033[0m"
elif [ $h -ge 10 ] && [ $m -ge 10 ]
then
  echo -e "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: $h:$m:00\033[0m  \033[37;44;1;82m#\033[0m"
else
  echo "Error, Program Exit!"
  exit 1
fi

sleep 1 && echo -ne "\033[5A\033[K\r"

if [ $h -gt 0 ] && [ $m -eq 0 ]
then
  h=$((h-1))
  m=59
fi

if [ $h -gt 0 ] || [ $m -gt 0 ]
then
  s=59
else
  s=0
fi

if [ $m -gt 0 ]
then
  m=$((m-1))
fi


while [ $h -le 24 ] && [ $h -ge 0 ]
do
  while [ $m -ge 0 ]
    do  
      while [ $s -ge 0 ]
      do
        if [ $h -le 9 ] && [ $m -le 9 ] && [ $s -le 9 ]
        then  
          echo -ne "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: 0$h:0$m:0$s\033[0m  \033[37;44;1;82m#\033[0m\033[K\r"
        elif [ $h -le 9 ] &&  [ $m -le 9 ] && [ $s -gt 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: 0$h:0$m:$s\033[0m  \033[37;44;1;82m#\033[0m\033[K\r"
        elif [ $h -le 9 ] &&  [ $m -gt 9 ] && [ $s -le 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: 0$h:$m:0$s\033[0m  \033[37;44;1;82m#\033[0m\033[K\r"
	elif [ $h -le 9 ] &&  [ $m -gt 9 ] && [ $s -gt 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: 0$h:$m:$s\033[0m  \033[37;44;1;82m#\033[0m\033[K\r"
	elif [ $h -gt 9 ] &&  [ $m -le 9 ] && [ $s -le 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: $h:0$m:0$s\033[0m  \033[37;44;1;82m#\033[0m\033[K\r"
	elif [ $h -gt 9 ] &&  [ $m -le 9 ] && [ $s -gt 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: $h:0$m:$s\033[0m  \033[37;44;1;82m#\033[0m\033[K\r"
	elif [ $h -gt 9 ] &&  [ $m -gt 9 ] && [ $s -le 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: $h:$m:0$s\033[0m  \033[37;44;1;82m#\033[0m\033[K\r" 
        else
          echo -ne "\033[37;44;1;82m#\033[0m  \033[30;48;5;82mTime: $h:$m:$s\033[0m  \033[37;44;1;82m#\033[0m\033[K\r"
        fi
        sleep 1 

        s=$((s-1))
     done
     s=59
     m=$((m-1))
  done
  m=59 
  h=$((h-1))
done 

sleep 1 && echo -ne "\033[K\r"

echo -e "\033[37;44;1;82m#\033[0m  \033[37;41;5;82mTime: 00:00:00\033[0m  \033[37;44;1;82m#\033[0m"
echo -e "\033[37;44;1;82m#\033[0m                  \033[37;44;1;82m#\033[0m"
echo -e "\033[37;44;1;82m####################\033[0m"
echo -e "\033[37;44;1;82m###  Time is up  ###\033[0m"
echo -e "\033[37;44;1;82m####################\033[0m"

zenity --notification --text="Work Time Finished"
zenity --warning --title="Work Timer" --icon-name="notification" --ellipsize --text="Work Time Finished"

sleep 1
for i in {1..9}
do
  echo -ne "\033[A\033[2K\r"
done
