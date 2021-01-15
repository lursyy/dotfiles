# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

echo -n -e "Startup..."

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ------------------------
# WSL 2 specific settings.
if grep -q "microsoft" /proc/version &>/dev/null; then

    # Export main display to the Windows host (Requires: https://sourceforge.net/projects/vcxsrv/)
    export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"

    # Allows your gpg passphrase prompt to spawn (useful for signing commits).
    export GPG_TTY=$(tty)

    
    # Some places say this has to be 1, some say 0. Currently it seems 0 is my bet :)
    export LIBGL_ALWAYS_INDIRECT=0
fi

# workaround for vscode (https://github.com/microsoft/WSL/issues/5065)
for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
    if [[ -e "/run/WSL/${i}_interop" ]]; then
        export WSL_INTEROP=/run/WSL/${i}_interop
    fi
done

# Is the XServer running yet?
if ! tasklist.exe | grep "vcxsrv.exe" &>/dev/null; then
    # use powershell to run the stored XServer config
    powershell.exe -Command Invoke-Item 'C:\"Program Files"\VcXsrv\WSL.xlaunch'
fi

# -------------------
# ROS stuff

# This works even when using fish, and is necessary fir tab completion to find stuff like roscore
source /opt/ros/melodic/setup.bash

# TODO change these into fish abbreviations
#alias bb='cd ~/catkin_ws && catkin_make && cd -'
#alias cdc='cd ~/catkin_ws/src/se-simulator/bebop_sim'
#alias dok='cd ~/git/dokumentation && code ~/git/dokumentation/source/includes && middleman server'

# This helps RosJava (running on the Windows Host) to find ros nodes
export ROS_IP=localhost

echo -e -n "\r"