#!/bin/bash

# Intro
echo
echo "Welcome to Android Debian chroot creator script"
echo "Based on instructions provided by Morten Bogeskov (bogeskov.dk)"
read -p "Press any key to begin..."

echo
echo "You must be logged in as root to run this script..."
echo "If not currently logged in as root please do so and restart script"
read -p "Press (x) to exit or any other key to continue." answ
	if [ "$answ" == "x" ]
		then exit
	fi

# Get required packages
echo
echo "Acquiring required packages (debootstrap qemu-user-static gparted)..."
#aptitude install debootstrap qemu-user-static gparted
# Directory installation menu 
answ=n
while [ "$answ" == "n" ]
do
	echo
	echo "Where would you like to build your chroot environment? (recommend /var/tmp/android)"
	read instDir

	# Check if dir exists
	if [ -d "$instDir" ]; 
	then
		echo
		echo "This directory already exists, continue?"
		echo
		echo "y - Continue installing in this directory anyways" 
  	echo "n - Choose different location"
		read -p "Choice: " answ
	fi

	if [ ! -d "$instDir" ];
		then #mkdir $instDir
	
		if [ $?==0 ];
			then 
				echo
				echo "Directory $instDir created successfully"
				break
		fi		
	fi
done

# Move qemu to chroot local 
cp /usr/bin/qemu-arm-static $instDir/usr/bin/

# Install ARM based deb image in directory
echo
echo "Choose a debian distro: " 
echo
echo "0- Squeeze 	(stable)"
echo "1- Wheezy 	(stable)"
echo "2- jessie 	(testing)"
echo "3- sid 		(unstable)"
echo
read -p "Choice: " distro

case $distro in
	0)	distro=squeeze;;
	1)	distro=wheezy;;
	2)	distro=jessie;;
	3) 	distro=sid;;
esac

#debootstrap --foreign --arch=armel $distro $instDir

if [ $?==0 ]	
	then 
		echo
		echo "Image created successfully"
fi		

mv script2.sh $instDir/root

chroot $instDir
/bin/bash

echo "made it!"
exit 0
