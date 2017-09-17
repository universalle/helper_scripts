#!/bin/bash

echo "Check if a database 'user_data' exists"

#INPUT DATA
echo "Enter mysql user:"
            read mysql_user
echo "Enter mysql pass:"
            read mysql_pass
#echo "Enter mysql db:"
#            read mysql_db

mysql_db="user_data"

#CHEKING

CHECK=`mysql --user=$mysql_user --password=$mysql_pass  --skip-column-names -e "SHOW DATABASES LIKE '$mysql_db'"`
if [ "$CHECK" == "$mysql_db" ]; then
    echo "Database exist"
else
   mysql --user=$mysql_user --password=$mysql_pass << EOF
   create database user_data;
   use user_data;
   create table users(id int auto_increment primary key, name text, surname text);
   create table data(year int, city text, country text);

EOF
  echo "Database '$mysql_db' created"
fi
