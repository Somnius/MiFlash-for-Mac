#!/bin/bash
# v0.1
clear
VER="0.1"

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
    echo "1 - Install ADB & Fastboot"
    echo "2 - Uninstall ADB & Fastboot"
	echo "3 - Flash Fastboot ROM"
    echo ""
    echo "0 - Quit"
    echo ""
    echo -n "Enter selection: "
    read selection
    echo ""
    case $selection in
        1 )
			df -h
			echo ""
			echo "..done"
			press_enter 
		;;
        2 )
			cat /proc/mem
			echo ""
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