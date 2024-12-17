#! /bin/bash

:'
Note:
((  ))
here we can use like other language
'

# only check one condition
count=10
if [ $count -eq 9 ]
then
	echo "This is 10"
else
	echo "This is not 10"
fi

# Not equal to check
a=5

if [ $a -ne 4 ]
then 
	echo "This is not 4"
else
	echo "This is 4"
	
fi


# greater then check (( > ))
b=4
if [ $b -gt 9 ]
then 
	echo "B is greater then 9 "
else
	echo "B is not greater then 9"
fi

if (( $b < 9 ))
then
	echo "B is less then 9"
else
	echo "B is greater then 9"
fi


# If elif else

abc=4

if [ $abc -eq 2 ]
then 
	echo "This is 2"
elif [ $abc -eq 4 ]
then
	echo "This is 4"
else
	echo "We don't know"
	
fi


:'
Now we learn about the and and or 
'

x=10

if [ "$x" -gt 18 ] && [  "$x" -lt 90 ]
then 
	echo "You can give the vote"
else
	echo "You can not give the vote"
fi

## OR

z=10 
if [ "$x" -gt 9 ] || [ "$x" -gt 18 ]
then
	echo "You are accepted"
else
	echo "Bye Bye"
fi
