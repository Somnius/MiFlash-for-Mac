#!/bin/bash
# v0.1
clear
VER="0.5"
###########################################################
### DON'T TOUCH THESE VARIABLES, DANGER OF DEVICE BRICK ###
CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
THEAPP="$CURDIR/MiFlash_Mac.app/"
###########################################################

# Text color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}*${txtrst}        # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}

if [[ $UID != 0 ]]; then
echo $(tput bold)"MiFlash for Mac v$VER" #set bold
	echo "created by @SomniusX"
	echo ""
echo $(tput setaf 1)"Please run this script with sudo:" #set red
    echo "sudo $0 $*"
echo $(tput sgr0) #reset colors
    exit 1
fi

function press_enter
{
    echo -n "Press Enter to continue"
    read
    clear
}

function press_enter2
{
    echo -n "Press Enter to start flashing.."
    read
}

function read_more
{
    echo -n "Press Enter to continue reading..."
    read
}

selection=
until [ "$selection" = "0" ]; do
echo $(tput bold)"MiFlash for Mac v$VER"
	echo "created by @SomniusX"
echo $(tput setaf 1) #set red
    echo "You need to be really carefull with the whole process"
	echo "and make sure you are connected to the Internet."
	echo "This program ONLY supports Xiaomi Mi3 and Mi4!!"
echo $(tput sgr0) #reset colors
echo $(tput bold)"1 - Install ADB & Fastboot Tools"
    echo "2 - Uninstall ADB & Fastboot Tools"
	echo "3 - Flash Fastboot ROM"
    echo ""
    echo "0 - Quit"
echo $(tput setaf 1) #set red
	echo -n "Enter selection: "
    read selection
echo $(tput sgr0) #reset colors
    case $selection in
        1 )
			echo "[INFO] Selected 1: Install ADB & Fastboot Tools"
#1 ---------- Using github.com/corbindavenport nexus tools
curl -s -o ./install.sh "https://raw.githubusercontent.com/corbindavenport/nexus-tools/main/install.sh" -LOk
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
curl -s -o ./uninstall.sh "https://raw.githubusercontent.com/corbindavenport/nexus-tools/main/uninstall.sh" -LOk
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
echo "[INFO] About to run Fastboot commands to your device."
echo "[INFO] If you are not sure that your devices is in fastboot mode or"
echo "[INFO] not even connected, plus if you haven't installed adb & fastboot"
echo "[INFO] ..time to hit that CTRL+C to stop this thing!"
echo ""
read_more
echo ""
echo "[INFO] Make sure you have extracted the \"contents\" of your fastboot rom"
echo "[INFO] on a folder named \"UPDATE\" (all CAPS) on your Desktop."
echo "[INFO] If not, you still have time until you continue, do that now or"
echo "[INFO] hit that CTRL+C to stop this thing!"
echo ""
read_more
echo ""
echo "[INFO] Script will display all available fastboot devices.. "
echo ""
fastboot devices
echo ""
echo "[INFO] You maybe seeing your available device in fastboot mode."
echo $(tput bold)"$(tput setaf 1)[WARN] $(tput sgr0)$(tput bold)IF YOU DON'T SEE YOUR DEVICE, hit that CTRL+C NOW to stop this thing!"$(tput sgr0)
echo ""
read_more
echo ""
echo "[INFO] If you have \"UPDATE\" folder with the fastboot rom contents on"
echo "[INFO] your Desktop then you are ready to the \"flashing\" !!"
echo $(tput bold)"[WARN] This process will wipe EVERYTHING inside your Phone!!" #set bold
echo $(tput setaf 1)"[WARN] CONTINUE ONLY IF YOU KNOW WHAT YOU ARE DOING !!!"
echo ""
read_more
echo ""
echo "[WARN] This is the end of the line, continue only if you are ready."
echo ""
echo $(tput sgr0) #reset colors
press_enter2
####################################################################################
####################################################################################
####################################################################################
### WARNING DON'T TAMPER WITH THE FOLLOWING CODE, YOU WILL BRICK YOUR DEVICE ###
fastboot $* getvar product 2>&1 | grep "^product: *MSM8974$"
if [ $? -ne 0 ] ; then 
	echo ""
	echo "$(tput bold)$(tput setaf 1)[WARN] Missmatching image and device, aborting...$(tput sgr0)"
	echo ""
	press_enter
	exit;
else
	echo "$(tput bold)$(tput setaf 2)[ OK ]Found image and device, flashing...$(tput sgr0)"
	echo ""
	fastboot $* flash tz ~/Desktop/UPDATE/images/tz.mbn
	fastboot $* flash dbi ~/Desktop/UPDATE/images/sdi.mbn
	fastboot $* flash sbl1 ~/Desktop/UPDATE/images/sbl1.mbn
	fastboot $* flash rpm ~/Desktop/UPDATE/images/rpm.mbn
	fastboot $* flash aboot ~/Desktop/UPDATE/images/emmc_appsboot.mbn
	fastboot $* erase boot
	fastboot $* flash misc ~/Desktop/UPDATE/images/misc.img
	fastboot $* flash modem+modem1 ~/Desktop/UPDATE/images/NON-HLOS.bin
	fastboot $* flash system+system1 ~/Desktop/UPDATE/images/system.img
	fastboot $* flash cache ~/Desktop/UPDATE/images/cache.img
	fastboot $* flash userdata ~/Desktop/UPDATE/images/userdata.img
	fastboot $* flash recovery ~/Desktop/UPDATE/images/recovery.img
	fastboot $* flash boot+boot1 ~/Desktop/UPDATE/images/boot.img
	fastboot $* reboot
fi
####################################################################################
####################################################################################
####################################################################################
			echo "$(tput bold)$(tput setaf 2)[ OK ] Flashing is complete, enjoy(tput sgr0)"
			echo ""
			press_enter
		;;
        0 )
			echo "Thank you for using MiFlash for Mac v$VER Script by @SomniusX"
echo $(tput sgr0) #reset colors
			exit
		;;
        * )
		echo $(tput setaf 1)"Please enter 1, 2, 3, or 0" #set red
		echo $(tput sgr0) #reset colors
		press_enter
    esac
done
