#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
apt install python3-mysqldb python3-pip
pip3 install python-magic bottle passlib beaker pymongo math secrets

db="DBleaks"
mongo --eval "db.credentials.createIndex({\"d\":\"hashed\"})" "$db" > /dev/null 2>&1
mongo --eval "db.credentials.createIndex({\"l\":\"hashed\"})" "$db" > /dev/null 2>&1
mongo --eval "db.createCollection(\"leaks\")" "$db" > /dev/null 2>&1

python3 init.py
