SENTORA="$(ls /var/ | grep sentora)"
KUSANAGI="$(ls /home/ | grep kusanagi)"
CWP="$(ls /usr/local/ | grep cwpsrv)"
DA="$(ls /usr/local/ | grep directadmin)"
VESTA="$(ls /usr/local/ | grep vesta)"
EE="$(ls /root/ | grep ee)"
Cyber="$(ls /etc/ | grep cyberpanel)"
EEV4="$(ls /var/lib/docker/ | grep volumes)"
UPD="$(ls /root/.config/script/ | grep rclone.sh)"
if [[ "$UPD" = "rclone.sh" ]]; then
	rm -f /root/.config/script/rclone.sh
fi

if [[ "$SENTORA" = "sentora" ]]; then
	wget -P /root/.config/script/ https://vncloudsco.github.io/rclonebackup/sentora/rclone.sh

elif [[ "$KUSANAGI" = "kusanagi" ]]; then
	wget -P /root/.config/script/ https://vncloudsco.github.io/rclonebackup/kusanagi/kusanagi.sh
	mv /root/.config/script/kusanagi.sh /root/.config/script/rclone.sh

elif [[ "$CWP" = "cwpsrv" ]]; then
	wget -P /root/.config/script/ https://vncloudsco.github.io/rclonebackup/CWP/rclone.sh

elif [[ "$DA" = "directadmin" ]]; then
	wget -P /root/.config/script/ https://vncloudsco.github.io/rclonebackup/directadmin/rclone.sh

elif [[ "$VESTA" = "vesta" ]]; then
	wget -P /root/.config/script/ https://vncloudsco.github.io/rclonebackup/vesta/rclone.sh
	
elif [[ "$EE" = "ee" ]]; then
	wget -P /root/.config/script/ https://vncloudsco.github.io/rclonebackup/ee/rclone.sh
	
elif [[ "$EEV4" = "volumes" ]]; then
	wget -P /root/.config/script/ https://vncloudsco.github.io/rclonebackup/ee/rclone.sh

elif [[ "$Cyber" = "cyberpanel" ]]; then
	wget -P /root/.config/script/ https://vncloudsco.github.io/rclonebackup/cyberpanel/rclone.sh

else
	wget -P /root/.config/script/ https://vncloudsco.github.io/rclonebackup/vnc/rclone.sh


fi
chmod 777 /root/.config/script/rclone.sh
crontab -l | { cat; echo "0 1 * * *  /root/.config/script/rclone.sh"; } | crontab -
crontab -l | { cat; echo "0 1 1 * *  wget https://vncloudsco.github.io/rclonebackup/rclone.sh && sh rclone.sh"; } | crontab -

