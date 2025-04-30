#!/usr/bin/env bash

mkdir $HOME/Minitel

cd $HOME/Minitel

### Télécharge le script de "Alexandre Montaron" ###
wget http://canal.chez.com/mntl.ti

### Installe le fichier ###
tic mntl.ti -o /etc/terminfo

### Pour que le fichier soit utilisé par agetty ###
agetty -c ttyUSB0 4800 minitel1b-80

### fichier de configuration systemd pour lancer le script au demarage ###
#sudo echo "# This file is part of systemd.\n#\n# systemd is free software; you can redistribute it and/or modify it\n# under the terms of the GNU Lesser General Public License as published\n# by the Free Software Foundation; either version 2.1 of the License,\n# or (at your option) any later version.\n\n[Unit]\nDescription=Serial Getty on %I\nDocumentation=man:agetty(8) man:systemd-getty-generator(8)\nDocumentation=http://0pointer.de/blog/projects/serial-console.html\nBindsTo=dev-%i.device\nAfter=dev-%i.device systemd-user-sessions.service plymouth-quit-wait.service\nAfter=rc-local.service\n# If additional gettys are spawned during boot then we should make\n# sure that this is synchronized before getty.target, even though\n# getty.target didn't actually pull it in.\nBefore=getty.target\nIgnoreOnIsolate=yes\n[Service]\nExecStart=-/sbin/agetty -c %i 4800 minitel1b-80\nType=idle\nRestart=always\nUtmpIdentifier=%I\nTTYPath=/dev/%I\nTTYReset=yes\nTTYVHangup=yes\nKillMode=process\nIgnoreSIGPIPE=no\nSendSIGHUP=yes\n[Install]\nWantedBy=getty.target" > /etc/systemd/system/serial-getty\@.service

### Chemin du fichier de service
SERVICE_FILE="/etc/systemd/system/serial-getty@.service"

### Contenu du fichier de service
SERVICE_CONTENT=$(cat << 'EOF'
# This file is part of systemd.
#
# systemd is free software; you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation; either version 2.1 of the License,
# or (at your option) any later version.

[Unit]
Description=Serial Getty on %I
Documentation=man:agetty(8) man:systemd-getty-generator(8)
Documentation=http://0pointer.de/blog/projects/serial-console.html
BindsTo=dev-%i.device
After=dev-%i.device systemd-user-sessions.service plymouth-quit-wait.service
After=rc-local.service
# If additional gettys are spawned during boot then we should make
# sure that this is synchronized before getty.target, even though
# getty.target didn't actually pull it in.
Before=getty.target
IgnoreOnIsolate=yes

[Service]
ExecStart=-/sbin/agetty -L -i -I “\033\143” 4800 %I minitel1b-80
Type=idle
Restart=always
UtmpIdentifier=%I
TTYPath=/dev/%I
TTYReset=yes
TTYVHangup=yes
KillMode=process
IgnoreSIGPIPE=no
SendSIGHUP=yes

[Install]
WantedBy=getty.target
EOF
)

# Écrire le contenu dans le fichier de service
echo "$SERVICE_CONTENT" | sudo tee $SERVICE_FILE > /dev/null

sudo ln -s $SERVICE_FILE /etc/systemd/system/getty.target.wants/serial-getty@ttyUSB0.service

sudo systemctl daemon-reload

sudo systemctl start serial-getty@ttyUSB0.service

echo "Brancher le cable USB/DIN, reboot dans 10 secondes..."

sleep 10

sudo reboot
