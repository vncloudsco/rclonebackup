SENTORA="$(ls /var/ | grep sentora)"
KUSANAGI="$(ls /home/ | grep kusanagi)"
CWP="$(ls /usr/local/ | grep cwpsrv)"
DA="$(ls /usr/local/ | grep directadmin)"
VESTA="$(ls /usr/local/ | grep vesta)"
EE="$(ls /etc/ | grep ee)"

if [[ "$SENTORA" = "sentora" ]]; then


elif [[ "$KUSANAGI" "kusanagi" ]]; then


elif [[ "$CWP" "cwpsrv" ]]; then


elif [[ "$DA" = "directadmin" ]]; then


elif [[ "$VESTA" = "vesta" ]]; then



elif [[ "$EE" = "ee" ]]; then

else


fi