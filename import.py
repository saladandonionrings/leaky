from pymongo import MongoClient
import sys
import os
import re
import argparse
import subprocess

mongo_database = "DBleaks"

# Valid URL schemes, domain pattern, and IP address with optional port
valid_url_schemes = ["http://", "https://", "ftp://", "ssh://", "android://", "imap://", "smb://", "sftp://", "pop3://", "smtp://"]
domain_pattern = re.compile(r'^(?!https?$)([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})(?::\d{1,5})?(?:/.*)?$')
ip_pattern = re.compile(r'^(?:\d{1,3}\.){3}\d{1,3}(?::\d{1,5})?(?:/.*)?$')
android_pattern = re.compile(r'^(android://[A-Za-z0-9_\-=+/]+@[a-zA-Z0-9.-]+/):([^:]+):(.+)$')

def is_valid_url(url):
    if any(url.startswith(scheme) for scheme in valid_url_schemes):
        return True
    if domain_pattern.match(url) or ip_pattern.match(url) or android_pattern.match(url):
        return True
    return False

def parse_line(line):
    # First, check for formats where URL is present
    match = re.match(r'^(https?://[^\s]+):([^:]+):(.+)$', line)
    if match:
        return match.group(1), match.group(2), match.group(3)
    match = re.match(r'^(ftp://[^\s]+):([^:]+):(.+)$', line)
    if match:
        return match.group(1), match.group(2), match.group(3)
    match = re.match(r'^(ssh://[^\s]+):([^:]+):(.+)$', line)
    if match:
        return match.group(1), match.group(2), match.group(3)
    match = re.match(android_pattern, line)
    if match:
        return match.group(1), match.group(2), match.group(3)
    
    # Check for domain-based or IP-based URL formats with optional port
    match = re.match(r'^([^:\s]+\.[a-zA-Z]{2,}(:\d{1,5})?[^\s]*):([^:]+):(.+)$', line)
    if match:
        return match.group(1), match.group(3), match.group(4)
    match = re.match(r'^((?:\d{1,3}\.){3}\d{1,3}(:\d{1,5})?[^\s]*):([^:]+):(.+)$', line)
    if match:
        return match.group(1), match.group(3), match.group(4)
    
    # Check for Login:Password only
    match = re.match(r'^([^:]+):([^:]+)$', line)
    if match:
        return "", match.group(1), match.group(2)
    
    return None

def remove_duplicates(file_path):
    print("🧹 Removing duplicates...")
    seen = set()
    unique_lines = []
    
    with open(file_path, "r", encoding="utf-8") as file:
        for line in file:
            line = line.strip()
            if line not in seen:
                seen.add(line)
                unique_lines.append(line)
    
    with open(file_path, "w", encoding="utf-8") as file:
        file.write("\n".join(unique_lines) + "\n")
    print("    ✅ Done")

def import_credentials(file_path, leak_date, leak_name=None):
    client = MongoClient()
    db = client[mongo_database]
    credentials = db["credentials"]
    leaks = db["leaks"]

    remove_duplicates(file_path)

    imported_count = 0
    skipped_count = 0

    leak_entry = leaks.find_one({"name": leak_name})
    if not leak_entry:
        leak_id = leaks.count_documents({}) + 1
        leaks.insert_one({"name": leak_name, "date": leak_date, "id": leak_id})
    else:
        leak_id = leak_entry["id"]

    with open(file_path, "r", encoding='utf-8') as file:
        print("📥 Importing...")
        for line in file:
            line = line.strip()
            if not line:
                continue

            result = parse_line(line)
            if result is None:
                skipped_count += 1
                print(f"    ❌ Skipping malformed line: {line}")
                continue

            url, login, password = result

            # Ensure login and password exist and are properly structured
            if not login or not password or login.strip() == "" or password.strip() == "":
                skipped_count += 1
                print(f"    ❌ Skipping invalid line (missing login/password): {line}")
                continue

            # Ensure the extracted URL is valid or empty
            if url and not is_valid_url(url):
                skipped_count += 1
                print(f"    ❌ Skipping invalid URL format: {url}")
                continue

            credential = {
                "l": leak_id,
                "url": url if url else "",
                "p": login,
                "P": password,
                "leakname": leak_name,
                "date": leak_date,
            }
            credentials.insert_one(credential)
            imported_count += 1


    print(f"✅ Imported {imported_count} credentials. ({skipped_count} lines skipped)")


def import_phone_numbers(file_path, leak_date, leak_name=None):
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
    with open(file_path, "r", encoding='utf-8') as file:
        for line in file:
            phone_number = line.strip()
            if phone_number:
                phone_number_doc = {
                    "l": new_id,
                    "phone": phone_number,
                    "leak_name": leak_name,
                    "leak_date": leak_date,
                }
                phone_numbers.insert_one(phone_number_doc)
                imported_count += 1
    print(f"✅ Imported {imported_count} phone numbers.")

def import_misc(file_path, leak_date, leak_name=None):
    client = MongoClient()
    db = client[mongo_database]
    miscfiles = db["miscfiles"]
    leaks = db["leaks"]

    leak = leaks.find_one({"name": leak_name})
    if not leak:
        new_id = leaks.count_documents({}) + 1
        leaks.insert_one({"name": leak_name, "date": leak_date, "id": new_id})
    else:
        new_id = leak["id"]

    imported_count = 0
    with open(file_path, "r", encoding='utf-8') as file:
        for line in file:
            misc_data = line.strip()
            if misc_data:
                misc_doc = {
                    "l": new_id,
                    "donnee": misc_data,
                    "leak_name": leak_name,
                    "leak_date": leak_date,
                }
                miscfiles.insert_one(misc_doc)
                imported_count += 1
    print(f"✅ Imported {imported_count} misc entries.")

def main():
    parser = argparse.ArgumentParser(description="Import leaked data into MongoDB")
    parser.add_argument("-f", "--file", required=True, help="Path to the file containing leaks")
    parser.add_argument("-d", "--date", required=True, help="Date of the leak")
    parser.add_argument("-n", "--name", help="Optional leak name")
    parser.add_argument("-t", "--type", required=True, choices=["creds", "phone", "misc"], help="Type of data to import")

    args = parser.parse_args()

    if not os.path.isfile(args.file):
        print("Invalid file path.")
        sys.exit(1)

    if args.type == "creds":
        import_credentials(args.file, args.date, args.name)
    elif args.type == "phone":
        import_phone_numbers(args.file, args.date, args.name)
    elif args.type == "misc":
        import_misc(args.file, args.date, args.name)
    else:
        print("❓ Invalid type specified.")
        sys.exit(1)

if __name__ == "__main__":
    main()
