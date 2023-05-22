# leaky
[![Python 3.5|3.6](https://img.shields.io/badge/python-3.x-green.svg)](https://www.python.org/) [![License](https://img.shields.io/badge/license-GPLv3-red.svg)](https://raw.githubusercontent.com/almandin/fuxploider/master/LICENSE.md)

Leaky is a robust suite of tools engineered for the processing and visualization of substantial text files containing credentials. Designed to aid pentesters and redteamers in their OSINT, credentials gathering, and credentials stuffing assaults, these tools deliver efficiency in handling massive amounts of data.

### Installation
```bash
# install mongodb
sudo apt-get install gnupg
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg \
   --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] http://repo.mongodb.org/apt/debian bullseye/mongodb-org/6.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# start mongodb
sudo systemctl enable mongod
sudo systemctl start mongod
# if failed :
sudo systemctl daemon-reload
sudo systemctl status mongod

# install project
git clone 
cd leakScraper
sudo ./install.sh
```

### Usage
- Make sure your leak file content is email:password

```bash
# escape weird characters
python3 clear-file.py -i <input_file> -o <output_file>

# change creds for users in db-users.py ; default : admin:admin
python3 db-users.py 

# import the file into mongodb
python3 import.py <file> <leak_name> <leak_date>

# start web instance on port 9999
python3 scraper.py
```
### Functionalities
- **Search** : search for domain name and/or name of one person
- **List of Leaks** : list of leaks implemented (name, number of credentials, date, remove)
- **Upload** : upload your own leak file into the mongodb instance and watch it being implemented into the web service

### Screenshots
**Search :**

**List of Leaks :**

**Upload :**


## Credits
This project is based on ACCEIS' LeakScraper https://github.com/Acceis/leakScraper