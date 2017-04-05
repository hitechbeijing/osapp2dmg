#!/bin/bash
printf "Please enter the OSAPP location ->"
read OSAPP
OSAPP="$OSAPP" | grep -o "[^ ]\+\( \+[^ ]\+\)*"
echo "OSAPP location $OSAPP"
#change to app location
#OSAPP="/Applications/Install\\ macOS\\ Sierra.app"
BUILDAPP="$OSAPP/Contents/SharedSupport/InstallESD.dmg"
#echo $BUILDAPP
ICNS="$OSAPP/Contents/Resources/InstallAssistant.icns"
printf "Please enter the OSAPP version, ep:Sierra ->"
read VERSION 
VERSION="$VERSION" | grep -o "[^ ]\+\( \+[^ ]\+\)*"
#VERSION=${$VERSION//' '/'_'}
#change to version name
#VERSION="Sierra"
echo "OSAPP version $VERSION"
printf "Please enter the volume name, ep: Install macOS Sierra - >"
read VOLUMES_NAME
VOLUMES_NAME="$VOLUMES_NAME" | grep -o "[^ ]\+\( \+[^ ]\+\)*"
echo "volume name $VOLUMES_NAME"
#sleep 60s
#mount app 
bash -c "hdiutil attach '$BUILDAPP' -noverify -nobrowse -mountpoint /Volumes/install_app"
  
#convert boot image to sparse bundle
bash -c "hdiutil convert /Volumes/install_app/BaseSystem.dmg -format UDRW -o '/tmp/$VERSION.base'"
  
#increase size of sparse bundle to 8g
hdiutil resize -size 8g /tmp/$VERSION.base.dmg
bash -c "hdiutil create -size 8g -fs HFS+J -volname '$VOLUMES_NAME'  '/tmp/$VERSION.dmg'"
#mount sparse bundle 
bash -c "hdiutil attach '/tmp/$VERSION.base.dmg' -nobrowse -noverify -mountpoint '/Volumes/$VERSION'"
bash -c "hdiutil attach '/tmp/$VERSION.dmg' -nobrowse -noverify -mountpoint '/Volumes/$VOLUMES_NAME'"
  
#replace package data 
bash -c "cp -Rp /volumes/$VERSION/* '/volumes/$VOLUMES_NAME'"
bash -c "rm -rf '/Volumes/$VOLUMES_NAME/System/Installation/Packages'"
bash -c "cp -rpf /Volumes/install_app/Packages '/Volumes/$VOLUMES_NAME/System/Installation/'"
bash -c "cp -rp /Volumes/install_app/BaseSystem.chunklist '/Volumes/$VOLUMES_NAME'"
bash -c "cp -rp /Volumes/install_app/BaseSystem.dmg '/Volumes/$VOLUMES_NAME'"

bash -c "cp -rp '$ICNS' '/Volumes/$VOLUMES_NAME'"

bash -c "mv '/Volumes/$VOLUMES_NAME/InstallAssistant.icns' '/Volumes/$VOLUMES_NAME/.VolumeIcon.icns'"
bash -c "setfile -a C '/Volumes/$VOLUMES_NAME'"

#umount all
hdiutil detach /Volumes/install_app
bash -c "hdiutil detach '/Volumes/$VERSION'"
bash -c "hdiutil detach '/Volumes/$VOLUMES_NAME'"
  
#resize sparse bundle
#hdiutil resize -size `hdiutil resize -limits /tmp/$VERSION | tail -n 1 | awk '{ print $1 }'`b /tmp/$VERSION
  
#convert to ISO/CD
#hdiutil convert /tmp/$VERSION -format UDTO -o /tmp/$VERSION

#convert to uncompressed dmg
#hdiutil convert /tmp/$VERSION -format UDRW -o /tmp/$VERSION

#convert to compressed dmg
bash -c "hdiutil convert '/tmp/$VERSION.dmg' -format UDCo -o '/tmp/$VERSION.compressed.dmg'"
  
#remove sparse bundle 
bash -c "rm -rf '/tmp/$VERSION.dmg'"
bash -c "rm -rf '/tmp/$VERSION.base.dmg'"

  
#move to desktop
mv /tmp/$VERSION.compressed.dmg ~/Desktop/$VERSION.dmg