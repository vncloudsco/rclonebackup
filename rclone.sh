SENTORA="$(ls /var/ | grep sentora)"
KUSANAGI="$(ls /home/ | grep kusanagi)"
CWP="$(ls /usr/local/ | grep cwpsrv)"
DA="$(ls /usr/local/ | grep directadmin)"
VESTA="$(ls /usr/local/ | grep vesta)"
EE="$(ls /root/ | grep ee)"
Cyber="$(ls /etc/ | grep cyberpanel)"

if [[ "$SENTORA" = "sentora" ]]; then
	wget -P /root/.config/script/ https://rclone.vnclouds.co/sentora/rclone.sh

elif [[ "$KUSANAGI" "kusanagi" ]]; then
	wget -P /root/.config/script/rclone.sh https://rclone.vnclouds.co/kusanagi/kusanagi.sh
	mv /root/.config/script/kusanagi.sh /root/.config/script/rclone.sh

elif [[ "$CWP" "cwpsrv" ]]; then
	wget -P /root/.config/script/ https://rclone.vnclouds.co/CWP/rclone.sh


elif [[ "$DA" = "directadmin" ]]; then
	wget -P /root/.config/script/ https://rclone.vnclouds.co/directadmin/rclone.sh


elif [[ "$VESTA" = "vesta" ]]; then
	wget -P /root/.config/script/ https://rclone.vnclouds.co/vesta/rclone.sh
	
elif [[ "$EE" = "ee" ]]; then
	wget -P /root/.config/script/ https://rclone.vnclouds.co/ee/rclone.sh

elif [[ "$Cyber" = "cyberpanel" ]]; then
	wget -P /root/.config/script/ https://rclone.vnclouds.co/cyberpanel/rclone.sh

else
	wget -P /root/.config/script/ https://rclone.vnclouds.co/vnc/rclone.sh


fi
chmod 777 /root/.config/script/rclone.sh
crontab -l | { cat; echo "0 1 * * *  /root/.config/script/rclone.sh"; } | crontab -
rm -f rclone.sh