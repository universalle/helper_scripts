#!/bin/bash

# Checking status of any services
echo "Enter service name to check status and run:"
            read servicename

ps aux | grep $servicename | grep -v grep > /dev/null
if [ $? -eq 0 ]; then
 echo "Service $servicename is running."
else
# echo "Service $servicename is not running."
 systemctl start httpd
 if [ $? -eq 0 ]; then
  echo "Service $servicename has been started"
 fi
fi
