from pymongo import MongoClient
from passlib.hash import pbkdf2_sha256
import os

mongo_database = "DBleaks"

client = MongoClient()
db = client[mongo_database]

users = db["users"]

# List of users to be added
user_list = [
    {"username": "leaky", "password": pbkdf2_sha256.hash("leaky")},
    # Add more users here...
]

# Insert the users
users.insert_many(user_list)
