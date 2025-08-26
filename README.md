# fix-audio-linux

1. clone the repo
2. move file fix-audio.sh to /usr/local/bin/
3. run command "sudo chmod +x /usr/local/bin/fix-audio.sh"
4. move fix-audio-once.service to /etc/systemd/system/
5. run those commands "sudo systemctl daemon-reload" and "sudo systemctl enable fix-audio-once.service"
6. after that, run "sudo reboot"

and now, you fixed no sound card error in linux
