#!/bin/bash
SERVER_NAME="$(ifconfig | grep broadcast | awk {'print $2'} | head -1)" # get IP
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/root/backup/$TIMESTAMP"
MYSQLPATH="$(mysql --help | grep "Default options" -A 1 | sed -n 2p | awk {'print $2'} | sed 's/\~/\/root/')"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
SECONDS=0
CHECKSQL="$(ls /usr/bin/ | grep mysql)"
NGINX="$(ls /etc/ | grep nginx)"
NGINX_DIR="$(nginx -V 2>&1 | grep -o '\-\-conf-path=\(.*conf\)' | grep -o '.*/' | awk -F '=' {'print $NF'})"
HTTPD="$(ls /etc/ | grep -w httpd)"
HTTPD_DIR="$(httpd -S 2>&1 | grep ServerRoot | sed 's/\"//g' | awk {'print $2'})"
LOG_DIR=/var/log/
EE="$(ls /root/ | grep ee)"
VNC_RCLONE="$(rclone config file | grep rclone.conf | sed 's/rclone.conf//')"
VNC_RCLONE_REMOTE="$(cat $VNC_RCLONE/rclone.conf | grep "\[" | sed 's/\[//' | sed 's/\]//')"
mkdir -p "$BACKUP_DIR"
echo "Starting Backup Website";
echo "VPS User easyengine ";
echo "Backup easyengine Config";
sleep 10
cp /etc/ee $BACKUP_DIR/easyengine
EECHEKER="$(ls /var/ | grep www)"
ap-get install zip -y
if [[ "$EECHEKER" = "www" ]]; then

echo "easyengine v3";
	for D in /var/www/*; do
    	if [ -d "${D}" ]; then #If a directory
     	   domain=${D##*/} # Domain name
        	echo "- "$domain;
     	   zip -r $BACKUP_DIR/$domain.zip /var/www/$domain -q -x /var/www/$domain/wp-content/cache/**\* # 

     	mkdir -p "$BACKUP_DIR/mysql"
     	MYSQL_USER="$(cat /var/www/$domain/wp-config.php | grep DB_USER | awk {'print $3'} | sed "s/'//g")"
     	MYSQL_PASSWORD="$(cat /var/www/$domain/wp-config.php | grep DB_PASSWORD | awk {'print $3'} | sed "s/'//g")"
     	db="$(cat /var/www/$domain/wp-config.php | grep DB_NAME | awk {'print $3'} | sed "s/'//g")"
    	$MYSQLDUMP --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/mysql/$db.sql.gz"
	echo "Finished";
	echo '';
   	 fi
	done

else
	echo "easyengine v4";

DOMAIN="$(ee site list | awk {'print $1'} | sed 's/site//' | sed '1d')" # => echo ra domain
for D in $DOMAIN; do
DB="$(ee site info $D | grep "DB Name" | awk {'print $5'})"
DB_USER="$(ee site info $D | grep "DB User" | awk {'print $5'})"
DB_Pass="$(ee site info $D | grep "DB Password" | awk {'print $5'})"
$MYSQLDUMP --user=$DB_USER -p$DB_Pass --databases $DB | gzip > "$BACKUP_DIR/mysql/$db.sql.gz"
done
DI="$(ee site list | awk {'print $1'} | sed 's/\.//' | sed 's/site//' | sed 's/$/_htdocs/' | sed '1d')"

	for D in /var/lib/docker/volumes/*; do
    	if [ -d "${D}" ]; then #If a directory
     	   domain=${D##*/} # Domain name
        	echo "- "$domain;
     	   zip -r $BACKUP_DIR/$domain.zip /var/lib/docker/volumes/$DI -q -x /var/lib/docker/volumes/$DI/_data/htdocs/wp-content/cache/**\* # 
     	fi
    done

fi

echo "khong co loi";

echo "Finished";
echo '';

echo "Starting Backup Server Configuration";
if [ "$NGINX" = "nginx" ] && [ "$HTTPD" = "httpd" ]
then
	echo "Starting Backup nginx proxy, apache backend Configuration";
	cp -r $NGINX_DIR $BACKUP_DIR/nginx
	cp -r $HTTPD_DIR $BACKUP_DIR/httpd
	cp -r $LOG_DIR $BACKUP_DIR/log
	echo "Finished";
	echo '';
elif [ "$NGINX" = "nginx" ];
then
	echo "Starting Backup NGINX Configuration";
	cp -r $NGINX_DIR/ $BACKUP_DIR/nginx
	cp -r $LOG_DIR $BACKUP_DIR/log
	echo "Finished";
	echo '';

elif [ "$HTTPD" = "httpd" ];
then
	echo "Starting Backup HTTPD (apache) Configuration";
	cp -r $HTTPD_DIR $BACKUP_DIR/httpd
	cp -r $LOG_DIR $BACKUP_DIR/log
	echo "Finished";
	echo '';
else
	echo "VPS directory http, nginx not found";
fi

size=$(du -sh $BACKUP_DIR | awk '{ print $1}')
echo "Starting Uploading Backup";

for i in $VNC_RCLONE_REMOTE
	do
		rclone copy $BACKUP_DIR "$i:$SERVER_NAME/$TIMESTAMP" >> /var/log/rclone.log 2>&1
	echo "done upload $i"
done

# Clean up

for i in $VNC_RCLONE_REMOTE
	do
		rclone -q --min-age 30d delete "$i:$SERVER_NAME"
	echo "done remote $i"
done

rm -rf $BACKUP_DIR
echo "Finished";
echo '';

duration=$SECONDS
echo "Total $size, $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."