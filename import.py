from pymongo import MongoClient
import sys
import os

# database parameters
mongo_database = "DBleaks"

def import_credentials(file_path, leak_name, leak_date):
    client = MongoClient()
    db = client[mongo_database]
    credentials = db["credentials"]
    leaks = db["leaks"]

    # Create index on leak name and date
    credentials.create_index([("leakname", 1), ("date", 1)])

    # Get the leak ID or create a new one
    leak = leaks.find_one({"name": leak_name})
    if not leak:
        new_id = leaks.count_documents({}) + 1
        leaks.insert_one({"name": leak_name, "date": leak_date, "id": new_id})
    else:
        new_id = leak["id"]

    # Read the file and import credentials
    imported_count = 0
    skipped_count = 0
    with open(file_path, "r") as file:
        for line in file:
            line = line.strip()
            if line:
                parts = line.split(":")
                if len(parts) == 2:
                    email, password = parts[0], parts[1]
                    email_parts = email.split("@")
                    if len(email_parts) == 2:
                        username, domain = email_parts[0], email_parts[1]
                        credential = {
                            "l": new_id,
                            "p": username,
                            "d": domain, 
                            "P": password,
                            "leakname": leak_name,
                            "date": leak_date
                        }
                        credentials.insert_one(credential)
                        imported_count += 1
                    else:
                        print(f"Skipped line due to bad email: {line}")
                        skipped_count += 1
                else:
                    print(f"Skipped line due to wrong parts: {line}")
                    skipped_count += 1
    print(f"Skipped {skipped_count} lines.")
    return imported_count


def main():
    if len(sys.argv) != 4:
        print("Usage: python3 import.py <file_path> <leak_name> <leak_date>")
        print("Example: python3 import.py credentials.txt tumblr 2013")
        return

    file_path = sys.argv[1]
    leak_name = sys.argv[2]
    leak_date = sys.argv[3]

    if not os.path.isfile(file_path):
        print("Invalid file path.")
        return

    imported_count = import_credentials(file_path, leak_name, leak_date)
    print(f"Imported {imported_count} credentials.")

if __name__ == "__main__":
    main()
