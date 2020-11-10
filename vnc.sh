#!/bin/bash
export DISPLAY=:99
LANG=ja_JP.UTF-8
LC_ALL=ja_JP.UTF-8
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

Xvfb :99 -screen 0 1920x1080x24 +extension GLX +render -noreset 2> xvfb.log & 
if [ ! -f ~/.vnc/passwd ] ; then
    vncpasswd
fi
sleep 3
/usr/bin/xfce4-session &
fcitx -r &
mlterm -k esc&
x11vnc -display :99 -shared -forever -repeat -rfbauth ~/.vnc/passwd -xkb 2> vnc.log &
wait

