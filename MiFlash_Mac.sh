#!/bin/bash
# v0.1
clear
VER="0.2"

if [[ $UID != 0 ]]; then
	echo "MiFlash for Mac v$VER"
	echo "created by @SomniusX"
	echo ""
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
	echo ""
    exit 1
fi

function press_enter
{
    echo ""
    echo -n "Press Enter to continue"
    read
    clear
}

selection=
until [ "$selection" = "0" ]; do
	echo "MiFlash for Mac v$VER"
	echo "created by @SomniusX"
	echo ""
    echo "You need to be really carefull with the whole process"
	echo "and be connected to the Internet."
	echo ""
    echo "1 - Install ADB & Fastboot Tools"
    echo "2 - Uninstall ADB & Fastboot Tools"
	echo "3 - Flash Fastboot ROM"
    echo ""
    echo "0 - Quit"
    echo ""
    echo -n "Enter selection: "
    read selection
    echo ""
    case $selection in
        1 )
			echo "Selected option 1: Install ADB & Fastboot Tools"
			echo ""
#1 ---------- Using github.com/corbindavenport nexus tools
curl -s -o ./install.sh "http://github.com/corbindavenport/nexus-tools/raw/master/install.sh" -LOk
chmod +x ./install.sh
sed -e 's/Nexus Tools/MiFlash for Mac/g' install.sh > install.sh.tmp
mv install.sh.tmp install.sh
bash ./install.sh
rm ./install.sh
			echo "..done"
			press_enter 
		;;
        2 )
			echo "Selected option 2: Uninstall ADB & Fastboot Tools"
			echo ""
curl -s -o ./uninstall.sh "http://github.com/corbindavenport/nexus-tools/raw/master/uninstall.sh" -LOk
chmod +x ./uninstall.sh
sed -e 's/Nexus Tools/MiFlash for Mac/g' uninstall.sh > uninstall.sh.tmp
mv uninstall.sh.tmp uninstall.sh
bash ./uninstall.sh
rm ./uninstall.sh
			echo "..done"
			press_enter
		;;
        3 )
			du -sh *
			echo ""
			echo "..done"
			press_enter
		;;
        0 )
			echo "Thank you for using MiFlash for Mac v$VER Script by @SomniusX"
			echo ""
			exit
		;;
        * ) echo "Please enter 1, 2, 3, or 0"; press_enter
    esac
done