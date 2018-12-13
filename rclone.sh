SENTORA="$(ls /var/ | grep sentora)"
KUSANAGI="$(ls /home/ | grep kusanagi)"
CWP="$(ls /usr/local/ | grep cwpsrv)"
DA="$(ls /usr/local/ | grep directadmin)"
VESTA="$(ls /usr/local/ | grep vesta)"
EE="$(ls /etc/ | grep ee)"
Cyber="$(ls /etc/ | grep cyberpanel)"

if [[ "$SENTORA" = "sentora" ]]; then
	wget http://rclone.vnclouds.co/sentora/rclone.sh

elif [[ "$KUSANAGI" "kusanagi" ]]; then
	wget http://rclone.vnclouds.co/kusanagi/rclone.sh

elif [[ "$CWP" "cwpsrv" ]]; then
	wget http://rclone.vnclouds.co/CWP/rclone.sh


elif [[ "$DA" = "directadmin" ]]; then
	wget http://rclone.vnclouds.co/directadmin/rclone.sh


elif [[ "$VESTA" = "vesta" ]]; then
	wget http://rclone.vnclouds.co/vesta/rclone.sh
	
elif [[ "$EE" = "ee" ]]; then
	wget http://rclone.vnclouds.co/ee/rclone.sh

elif [[ "$Cyber" = "cyberpanel" ]]; then
	wget http://rclone.vnclouds.co/cyberpanel/rclone.sh

else
	wget http://rclone.vnclouds.co/vnc/rclone.sh


fi