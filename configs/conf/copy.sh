#!/bin/bash
chadwm (){
   sudo mkdir /usr/share/xsessions/
   sudo cp ./configs/conf/chadwm/chadwm.desktop /usr/share/xsessions/
   cp ./configs/conf/chadwm/Xresources ~/.Xresources
}

sddm (){
   sudo cp ./configs/conf/sddm/fakesudo.face.icon /usr/share/sddm/faces/
   sudo cp ./configs/conf/sddm/default.conf /lib/sddm/sddm.conf.d/
   sudo cp ./configs/conf/sddm/theme.conf  /usr/share/sddm/themes/chili/
   sudo cp ./configs/conf/sddm/background.jpg  /usr/share/sddm/themes/chili/assets/
}

xorg (){
   sudo cp ./configs/conf/xorg/* /etc/X11/xorg.conf.d/
}

chadwm
sddm
xorg
