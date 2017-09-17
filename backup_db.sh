#!/bin/bash

# Backup directory
backup_path="/home/backups"

# Store backups dates
date=$(date +"%d-%b-%Y")

# Check if backup folder exists
[ ! -d $backup_path ] && mkdir -p ${backup_path} 

# INPUT DATA
echo "***************"
echo "Backup database"
echo "***************"
echo "Enter mysql database to backup:"
            read mysql_db
echo "Enter mysql user:"
            read mysql_user

# CHECK DB
CHECK=`mysql -u $mysql_user -p$mysql_pass --skip-column-names -e "SHOW DATABASES LIKE '$mysql_db'"`
if [ "$CHECK" == "$mysql_db" ]; then
# Set default file permissions
     umask 177
# Dump database and zip
    echo "Database exist. Dumping database: $mysql_db"
    mysqldump --user=$mysql_user --password=$mysql_pass $mysql_db > $backup_path/db_$mysql_db-$date.sql
    gzip $backup_path/db_$mysql_db-$date.sql
    echo "Done!"
else
    echo "Database does not exist"
fi

echo "****************"
echo "Backup websever"
echo "****************"
echo "Enter webhost to backup:"
            read hostname

# CHECK WEB
if [ -d $hostname ]; then

# Backup websever dirs
    tar czf $backup_path/www_${hostname}_${date}.tar -C / var/www/$hostname
    gzip $backup_path/www_${hostname}_${date}.tar
    echo "Done!"
else
    echo "Webserver does not exist"
fi

# Delete files older than 2 weeks
find $backup_path/db* -mtime +14 -exec rm {} \;
find $backup_path/www* -mtime +14 -exec rm {} \;













