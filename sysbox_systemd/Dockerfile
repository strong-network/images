#
# Sysbox Base Image + Systemd
#
# Description:
#
# This image serves purpose of running Systemd inside a system (sysbox) container 
# in order to deploy various services within the system container

FROM sn_sysbox_base

COPY strong_entrypoint.sh /usr/bin/strong_setup.sh
COPY ./services/* /lib/systemd/system/


#
# Systemd installation
#
RUN apt-get update &&                            \
    apt-get install -y --no-install-recommends   \
            systemd                              \
            systemd-sysv                         \
            libsystemd0                          \
            ca-certificates                      \
            dbus                                 \
            iptables                             \
            iproute2                             \
            kmod                                 \
            locales                              \
            sudo                                 \
            udev &&                              \
                                                 \
    # Prevents journald from reading kernel messages from /dev/kmsg
    echo "ReadKMsg=no" >> /etc/systemd/journald.conf &&               \
                                                                      \
    # Housekeeping
    apt-get clean -y &&                                               \
    rm -rf                                                            \
       /var/cache/debconf/*                                           \
       /var/lib/apt/lists/*                                           \
       /var/log/*                                                     \
       /tmp/*                                                         \
       /var/tmp/* 
                                                                      

# Disable systemd services/units that are unnecessary within a container.
RUN systemctl mask systemd-udevd.service        \
                   systemd-udevd-kernel.socket  \
                   systemd-udevd-control.socket \
                   systemd-modules-load.service \
                   sys-kernel-config.mount      \
                   sys-kernel-debug.mount       \
                   sys-kernel-tracing.mount 


RUN chmod +rwx /usr/bin/strong_setup.sh     &&  \
    systemctl enable strong-setup.service       \
                    tmp-umount.service          
                    # we need to install docker different way for this
                    # docker.service 

# Make use of stopsignal (instead of sigterm) to stop systemd containers.
STOPSIGNAL SIGRTMIN+3

WORKDIR /home/developer

# Set systemd as entrypoint.
ENTRYPOINT [ "/sbin/init", "--log-level=err" ]