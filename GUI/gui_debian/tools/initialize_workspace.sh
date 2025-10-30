#!/bin/sh

mkdir -p "$HOME/.vnc"

# set vncserver passwordup
if [ -f "$HOME/.vnc/passwd" ]; then
    echo "$HOME/.vnc/passwd exists."
else
    echo "create $HOME/.vnc/passwd."
    echo "vncpassword" | vncpasswd -f > "$HOME/.vnc/passwd"
    chmod 600 "$HOME/.vnc/passwd"
fi

# copy gnome and xfce4 startup file
if [ -f "$HOME/.vnc/xstartup.xfce4" ]; then
    echo "$HOME/.vnc/xstartup.xfce4 exists."
else
    echo "copy $HOME/.vnc/xstartup.xfce4."
    cp /usr/bin/strong_network_startup/xstartup/xstartup.xfce4 $HOME/.vnc/xstartup.xfce4
    chmod +x $HOME/.vnc/xstartup.xfce4
fi

# start tightvnc, using xfce4 by default
export USER=developer
killall -9 Xtigervnc
find /tmp -name ".X[1-6]-lock" | xargs rm -rf
find /tmp/.X11-unix -name "X[1-6]" | xargs rm -rf
cp $HOME/.vnc/xstartup.xfce4 $HOME/.vnc/xstartup
chmod +x $HOME/.vnc/xstartup
vncserver -geometry 4096x2160 -depth 24

# start novnc
/usr/share/novnc/utils/novnc_proxy --listen 8081 --vnc localhost:5901