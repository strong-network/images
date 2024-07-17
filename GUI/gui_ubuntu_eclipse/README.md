## NoVNC Eclipse Image

This page will cover the basic information and how to start using the ubuntu image to have a full graphical desktop environment.

## Information

This image it's built on top of the Ubuntu minimal VNC an installs additional tools: Python 3, Eclipse, VSCode and SVN.

## Instructions

1. Create a workspace using the image
2. Expose port 8081 as a workspace app
3. Start the workspace and run the following command in the terminal to start the no VNC client:

```
/usr/bin/strong_network_startup/xstartup/initialize_workspace.sh
```

4. Open the workspace app, you should see the Ubuntu Desktop desktop.

To automatize this procedure you may include the previous command in the startup script and create a workspace template with a workspace app already created exposing the 8081 port.
