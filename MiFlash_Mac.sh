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
			echo "[INFO] Selected 1: Install ADB & Fastboot Tools"
#1 ---------- Using github.com/corbindavenport nexus tools
curl -s -o ./install.sh "http://github.com/corbindavenport/nexus-tools/raw/master/install.sh" -LOk
chmod +x ./install.sh
sed -e 's/Nexus Tools/MiFlash for Mac/g' install.sh > install.sh.tmp && mv install.sh.tmp install.sh
sed -e 's/Type adb or fastboot to run/adb and fastboot are installed on your system/g' install.sh > install.sh.tmp && mv install.sh.tmp install.sh
bash ./install.sh
rm ./install.sh
			echo "[ OK ] sub-process is complete"
			press_enter 
		;;
        2 )
			echo "[INFO] Selected 2: Uninstall ADB & Fastboot Tools"
#2 ---------- Using github.com/corbindavenport nexus tools
curl -s -o ./uninstall.sh "http://github.com/corbindavenport/nexus-tools/raw/master/uninstall.sh" -LOk
chmod +x ./uninstall.sh
sed -e 's/Nexus Tools/MiFlash for Mac/g' uninstall.sh > uninstall.sh.tmp
mv uninstall.sh.tmp uninstall.sh
bash ./uninstall.sh
rm ./uninstall.sh
			echo "[ OK ] sub-process is complete"
			echo "[WARN] Program cannot continue without adb and fastboot"
			echo "[INFO] ..terminating"
			echo ""
			echo "Thank you for using MiFlash for Mac v$VER Script by @SomniusX"
			press_enter
			exit
		;;
        3 )
			du -sh *
			echo "[ OK ] sub-process is complete"
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