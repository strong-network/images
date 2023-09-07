#!/usr/bin/env bash
set +x

source $HOME/.bashrc

## change vnc password
PASSWD_PATH="$HOME/.vnc/passwd"


if [[ -f $PASSWD_PATH ]]; then
    echo -e "\n---------  purging existing VNC password settings  ---------"
    rm -f $PASSWD_PATH
fi

echo "$VNC_PW" | vncpasswd -f >> $PASSWD_PATH
chmod 600 $PASSWD_PATH

# Start NO VNC server
/developer/.noVNC/utils/launch.sh --vnc 0.0.0.0:$VNC_PORT --listen $NO_VNC_PORT  &> $HOME/no_vnc_startup.log &

# remove old vnc server locks
vncserver -kill $DISPLAY &> $HOME/vnc_startup.log \
    || sudo rm -rfv /tmp/.X*-lock /tmp/.X11-unix &> $HOME/vnc_startup.log \
    || echo "no locks present"

# start VNC server
tigervncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION -IdleTimeout=0 &> $HOME/vncserver_startup.log

until pids=$(pidof xfce4-session); do sleep .5; done
