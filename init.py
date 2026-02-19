from pymongo import MongoClient
from passlib.hash import pbkdf2_sha256

admin_password = "leaky123" # CHANGETHIS

hashed_password = pbkdf2_sha256.hash(admin_password)

client = MongoClient()
db = client["DBleaks"]

db['access'].insert_one({'type': 'admin_password', 'password': hashed_password})
