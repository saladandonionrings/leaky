from pymongo import MongoClient
from passlib.hash import pbkdf2_sha256
import os

mongo_database = "DBleaks"

client = MongoClient()
db = client[mongo_database]

users = db["users"]

# List of users to be added
user_list = [
    {"username": "admin", "password": pbkdf2_sha256.hash("admin")},
    # Add more users here...
]

# Insert the users
users.insert_many(user_list)
