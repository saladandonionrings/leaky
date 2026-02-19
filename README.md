# leaky :key:
[![Python 3.5|3.6](https://img.shields.io/badge/python-3.x-green.svg)](https://www.python.org/) 
[![License](https://img.shields.io/badge/license-GPLv3-red.svg)](https://raw.githubusercontent.com/almandin/fuxploider/master/LICENSE.md)

Leaky is an arsenal of tools designed for parsing and visualizing colossal text files laden with credentials and stealer logs (in the ULP format). Built to aid penetration testers and redteamers in OSINT, credential gathering, and credential stuffing attacks, this suite delivers an efficient way to manage and investigate leaked data at scale.

## ⚠️ Disclaimer  
This project is intended for **educational and professional use only**. It is designed for **penetration testers**, **red team / blue team members**, and **cybersecurity professionals** working in legal and authorized contexts (OSINT, security assessments, leak analysis, etc.).  
**No illegal or unethical activity is encouraged, promoted, or supported** by the authors of this project. Use responsibly and within the bounds of applicable laws.

## :star2: Credits
This project is built upon the foundational work of [ACCEIS' LeakScraper](https://github.com/Acceis/leakScraper).

## Installation

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

### Usage
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
# change creds for users in init.py
python3 init.py 

# import the file into mongodb
python3 import.py -t {creds,phone,misc} -f <file> -n <leak_name> -d <leak_date>

# start web instance on port 9999 ; default pass -> leaky123
python3 scraper.py
```
### Functionalities
Leaky provides the following capabilities:

* **Search** : As it says.
* **Inventory** : Inventory of your breach files.
* **Upload** : Add your own breach files.
* **Links** : Useful links for data leaks.

#### Search
##### Credentials/ULP
![search](https://github.com/user-attachments/assets/63da8750-24da-4c3a-9a58-edea90bee637)

##### Phone
![phones](https://github.com/user-attachments/assets/0e2fa15a-dd32-4b36-9dd2-567dab61d1f7)

##### Misc
![csv](https://github.com/user-attachments/assets/d6a921ee-8409-4bb1-9a41-03209500aa50)

#### Inventory
![list](https://github.com/user-attachments/assets/cf8612b3-6215-49c9-8f0d-19c56f1b2c27)

#### Upload
![upload](https://github.com/user-attachments/assets/ae9f33e9-f35f-4443-886c-f85a8e1d9558)

#### Links
![links](https://github.com/user-attachments/assets/0ffc22c2-70b6-47d3-890a-bbd694106579)
