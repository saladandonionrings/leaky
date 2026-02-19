#!/bin/bash
set -e  # Stops the script if errors

# Common errors Mongodb
echo "> Checking if mongodb has no errors"
sudo mkdir -p /var/log/mongodb
sudo chown -R mongodb:mongodb /var/log/mongodb
sudo chmod -R 755 /var/log/mongodb
sudo systemctl restart mongod

# URI MongoDB
MONGO_URI=${MONGO_URI:-"mongodb://127.0.0.1:27017/DBleaks"}

echo "Installing Python dependencies..."
pip3 install --no-cache-dir -r requirements.txt

echo "Configuring MongoDB indexes and collections..."
mongosh "$MONGO_URI" --eval "db.credentials.createIndex({\"l\":\"hashed\"})"
mongosh "$MONGO_URI" --eval "db.credentials.createIndex({\"url\":\"hashed\"})"
mongosh "$MONGO_URI" --eval "db.credentials.createIndex({\"leakname\":1, \"date\":1})"

# Create indexes
mongosh "$MONGO_URI" --eval "db.phone_numbers.createIndex({\"l\":\"hashed\"})"
mongosh "$MONGO_URI" --eval "db.phone_numbers.createIndex({\"phone\":1})"
mongosh "$MONGO_URI" --eval "db.miscfiles.createIndex({\"l\":\"hashed\"})"
mongosh "$MONGO_URI" --eval "db.miscfiles.createIndex({\"donnee\":1})"

# Create collections
mongosh "$MONGO_URI" --eval "db.createCollection(\"leaks\")"
mongosh "$MONGO_URI" --eval "db.createCollection(\"phone_numbers\")"
mongosh "$MONGO_URI" --eval "db.createCollection(\"miscfiles\")"

echo "Creating initial users..."
python3 init.py

echo "Setup completed successfully!"
