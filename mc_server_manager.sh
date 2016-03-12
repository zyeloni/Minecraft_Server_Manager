#!/bin/bash

#	AUTHOR: Kacper Łukasik
#	Project website: https://github.com/UkasikPL/Minecraft_Server_Manager/
# 	Version: 0.2 Alpha

DW_PATH="http://getspigot.org/jenkins/job/CraftBukkit/lastSuccessfulBuild/artifact/craftbukkit-1.9.jar"

INSTALL_DIR="src"

MAX_RAM="1024"
A="-Xmx"
B="M"

function install {
	mkdir $INSTALL_DIR
	cd $INSTALL_DIR
	wget "$DW_PATH"
	cd "../"
}


# CREATE DIR
if [ ! -e $INSTALL_DIR ]; then
	mkdir $INSTALL_DIR
fi

#IF Craftbukkit.jar not exist download it
if [ ! -e "$INSTALL_DIR/craftbukkit-1.9.jar" ]; then
	cd $INSTALL_DIR
	wget "$DW_PATH"
	cd "../"
fi

#Create elua and set true
if [ ! -e "$INSTALL_DIR/elua.txt" ]; then
	echo "eula=true" > "$INSTALL_DIR/eula.txt"
fi

#Start server
if [ $# -eq 1 ] || [ $# -eq 2 ]; then
	if [ -e "$INSTALL_DIR/craftbukkit-1.9.jar" ] && [ $1 = "start" ]; then

		echo "====================================="
		echo "Set the amount of RAM: [MB]"
		read MAX_RAM
		echo "====================================="

		cd $INSTALL_DIR
		java "$A$MAX_RAM$B" -jar craftbukkit-1.9.jar -o true
	else if [ $1 = "reinstall" ]; then
		rm -r $INSTALL_DIR
		install
	fi
	fi
fi	
