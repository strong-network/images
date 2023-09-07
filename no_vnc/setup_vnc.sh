
mkdir  -m 777 -p "/developer/.vnc"
cat > /developer/.vnc/xstartup <<EOL
#!/bin/bash

PATH=/usr/bin:/usr/sbin
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4 -- replace &
EOL

chmod +x /developer/.vnc/xstartup