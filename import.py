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
    credentials.create_index([("leakname", 1), ("date", 1)])
    leak = leaks.find_one({"name": leak_name})
    if not leak:
        new_id = leaks.count_documents({}) + 1
        leaks.insert_one({"name": leak_name, "date": leak_date, "id": new_id})
    else:
        new_id = leak["id"]
    imported_count = 0
    skipped_count = 0
    with open(file_path, "r") as file:
        for line in file:
            line = line.strip()
            if line:
                if line.startswith('http://') or line.startswith('https://'):
                    parts = line.split(':')
                    if len(parts) >= 3:
                        url = parts[0] + ':' + parts[1]
                        email, password = ':'.join(parts[2:-1]), parts[-1]
                    else:
                        print(f"Skipped line due to wrong format: {line}")
                        skipped_count += 1
                        continue
                else:
                    parts = line.split(':')
                    if len(parts) == 2:
                        url, email, password = None, parts[0], parts[1]
                    else:
                        print(f"Skipped line due to wrong format: {line}")
                        skipped_count += 1
                        continue
                email_parts = email.split("@")
                if len(email_parts) == 2:
                    username, domain = email_parts[0], email_parts[1]
                    credential = {
                        "l": new_id,
                        "p": username,
                        "d": domain, 
                        "P": password,
                        "url": url,
                        "leakname": leak_name,
                        "date": leak_date
                    }
                    credentials.insert_one(credential)
                    imported_count += 1
                else:
                    print(f"Skipped line due to bad email: {line}")
                    skipped_count += 1
    print(f"Imported {imported_count} credentials. Skipped {skipped_count} lines.")

def import_phone_numbers(file_path, leak_name, leak_date):
    client = MongoClient()
    db = client[mongo_database]
    phone_numbers = db["phone_numbers"]
    leaks = db["leaks"]
    leak = leaks.find_one({"name": leak_name})
    if not leak:
        new_id = leaks.count_documents({}) + 1
        leaks.insert_one({"name": leak_name, "date": leak_date, "id": new_id})
    else:
        new_id = leak["id"]
    imported_count = 0
    with open(file_path, "r") as file:
        for line in file:
            phone_number = line.strip()
            if phone_number:
                phone_number_doc = {
                    "l": new_id,
                    "phone": phone_number,
                    "leak_name": leak_name,
                    "leak_date": leak_date
                }
                phone_numbers.insert_one(phone_number_doc)
                imported_count += 1
    return imported_count

def import_misc(file_path, leak_name, leak_date):
    client = MongoClient()
    db = client[mongo_database]
    donnees = db["miscfiles"]
    leaks = db["leaks"]
    leak = leaks.find_one({"name": leak_name})
    if not leak:
        new_id = leaks.count_documents({}) + 1
        leaks.insert_one({"name": leak_name, "date": leak_date, "id": new_id})
    else:
        new_id = leak["id"]
    imported_count = 0
    with open(file_path, "r") as file:
        for line in file:
            donnee = line.strip()
            if donnee:
                donnee_doc = {
                    "l": new_id,
                    "donnee": donnee,
                    "leak_name": leak_name,
                    "leak_date": leak_date
                }
                donnees.insert_one(donnee_doc)
                imported_count += 1
    return imported_count


def main():
    if len(sys.argv) < 5:
        print("Usage:")
        print("Credentials: python3 import.py creds <file_path> <leak_name> <leak_date>")
        print("Phone numbers: python3 import.py phone <file_path> <leak_name> <leak_date>")
        print("SQL/CSV/JSON: python3 import.py misc <file_path> <leak_name> <leak_date>")
        sys.exit(1)

    import_type = sys.argv[1]
    file_path = sys.argv[2]
    leak_name = sys.argv[3]
    leak_date = sys.argv[4]

    if not os.path.isfile(file_path):
        print("Invalid file path.")
        sys.exit(1)

    client = MongoClient()
    client[mongo_database]

    if import_type == "creds":
        imported_count = import_credentials(file_path, leak_name, leak_date)
        print(f"Imported {imported_count} credentials.")
    elif import_type == "phone":
        imported_count = import_phone_numbers(file_path, leak_name, leak_date)
        print(f"Imported {imported_count} phone numbers.")
    elif import_type == "misc":
        imported_count = import_misc(file_path, leak_name, leak_date)
        print(f"Imported {imported_count} lines.")
    else:
        print("Invalid import type specified.")
        sys.exit(1)

if __name__ == "__main__":
    main()
