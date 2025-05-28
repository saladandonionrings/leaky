# leaky :key:
[![Python 3.5|3.6](https://img.shields.io/badge/python-3.x-green.svg)](https://www.python.org/) 
[![License](https://img.shields.io/badge/license-GPLv3-red.svg)](https://raw.githubusercontent.com/almandin/fuxploider/master/LICENSE.md)

Leaky is a potent arsenal of tools designed for parsing and visualizing colossal text files laden with credentials and stealer logs (in the ULP format). Built to aid penetration testers and redteamers in OSINT, credential gathering, and credential stuffing attacks, this suite delivers an efficient way to manage and investigate leaked data at scale.

## :star2: Credits
This project is built upon the foundational work of [ACCEIS' LeakScraper](https://github.com/Acceis/leakScraper).

## :gear: Installation

You can install Leaky and its prerequisites using the following commands:

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
git clone https://github.com/saladandonionrings/leaky.git
cd leaky
sudo ./install.sh
```

### :rocket: Usage
### File types supported
- TXT 
  - Stealer Logs (URL:Login:Password)
  - Combos list (Login:Password)
  - Phone numbers
- SQL
- CSV
- JSON

### Importing data

```bash
# change creds for users in db-users.py
python3 init.py 

# import the file into mongodb
python3 import.py -t {creds,phone,misc} -f <file> -n <leak_name> -d <leak_date>

# start web instance on port 9999 ; default pass -> leaky123
python3 scraper.py
```
### :mag_right: Functionalities
Leaky provides the following capabilities:

* **Search** : Search for leaked data.
* **List of Leaks** : Access the directory of leaks (includes name, number of credentials, date, remove).
* **Upload** : Integrate your own leak file into the mongodb instance and watch it reflect on the web service.
* **Links** : Useful links for data leaks.

#### Search
##### Credentials
![search](https://github.com/user-attachments/assets/9253220e-9d02-4523-803d-d40290c6d5e7)

##### Phone
![phones](https://github.com/user-attachments/assets/3c435c44-9a5b-474b-bbac-b9d375cc04d6)

##### Misc
![sql](https://github.com/user-attachments/assets/c94a2006-619a-4ce9-aa03-cf88040eed8f)

#### List of leaks
![list](https://github.com/user-attachments/assets/e9feed06-e289-4dc9-b1d3-21d8faa90807)

#### Upload
![upload](https://github.com/user-attachments/assets/3785fb49-7fa3-404e-be12-b3efc1086802)

#### Links
![links](https://github.com/user-attachments/assets/2fa0a902-4bf8-4db0-be22-4bdc35ec1c23)
