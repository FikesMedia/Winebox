#!/bin/bash

# Winbox for Wine Installer


function displayHelp() {
  echo "---------------------------------------------"
  echo "Unofficial Winbox installer for Fedora/Debian"
  echo "                       provided by FikesMedia"
  echo "---------------------------------------------"
  echo " "
  echo "Usage: winebox.sh (install | remove | update)"
  echo " "
}

function installRequirements(){
  # Check for wine64
  if ! command -v wine64 &> /dev/null
  then
    # Install Wine64 Fedora
    if command -v dnf &> /dev/null
    then
      dnf install wine64 -y
    fi
    # Install Wine64 Ubuntu / Debian
    if command -v apt &> /dev/null
    then
      apt install wine64 -y
    fi
  fi
}

function installWinbox(){
  # Get Full Home Path
  userHome=$(echo ~)

  # Create Application Folders in Home
  mkdir -p $userHome/Applications/Windows/Winbox/

  # Download Winbox
  wget -O $userHome/Applications/Windows/Winbox/winbox64.exe https://mt.lv/winbox64

  # Create Icon File
  wget -O $userHome/Applications/Windows/Winbox/winbox.png https://raw.githubusercontent.com/FikesMedia/Winebox/main/winbox.png?token=GHSAT0AAAAAABZTFB6HW2K4IAIIXFUPPR5IY26TLHQ

  # Create Desktop File
  desktopFile="$userHome/Applications/Windows/Winbox/winbox.desktop"
  echo "[Desktop Entry]" > $desktopFile
  echo "Type=Application" >> $desktopFile
  echo "Name=Winbox" >> $desktopFile
  echo "Icon=$userHome/Applications/Windows/Winbox/winbox.png" >> $desktopFile
  echo "Exec=sh -c 'cd $userHome/Applications/Windows/Winbox; wine64 winbox64.exe'" >> $desktopFile
  echo "Terminal=false" >> $desktopFile
  echo "Categories=Internet;" >> $desktopFile

  # Link Desktop File
  ln -s $desktopFile $userHome/.local/share/applications/winbox.desktop

}

function removeWinbox(){
  # Get Full Home Path
  userHome=$(echo ~)  
  
  # Remove Shortcut
  rm $userHome/.local/share/applications/winbox.desktop

  # Remove Applications
  rm -rf $userHome/Applications/Windows/Winbox/ 

}

function updateWinbox(){ 
  # Get Full Home Path
  userHome=$(echo ~)
  
  # Download Winbox
  wget -O $userHome/Applications/Windows/Winbox/winbox64.exe https://mt.lv/winbox64

}

function confirmationPage(){
  echo " "
  echo "---------------------------------------------"
  echo "Unofficial Winbox installer for Fedora/Debian"
  echo "                       provided by FikesMedia"
  echo "---------------------------------------------"
  echo " "
  echo "$1 Complete"
  echo " "
}

# Check for usage
if [ -z "$1" ]
then
  displayHelp
  exit
fi

# Install Winbox
if [ $1 == "install" ]
then
  installRequirements
  installWinbox
  confirmationPage Installation
fi

# Remove Winbox
if [ $1 == "remove" ]
then
  removeWinbox
  confirmationPage Removal
fi


# Update Winbox
if [ $1 == "update" ]
then
  updateWinbox
  confirmationPage Update
fi
