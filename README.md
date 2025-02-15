# leaky :key:
[![Python 3.5|3.6](https://img.shields.io/badge/python-3.x-green.svg)](https://www.python.org/) 
[![License](https://img.shields.io/badge/license-GPLv3-red.svg)](https://raw.githubusercontent.com/almandin/fuxploider/master/LICENSE.md)

Leaky is a potent arsenal of tools designed for parsing and visualizing colossal text files laden with credentials. Built with the goal to aid penetration testers and redteamers in OSINT, credentials gathering, and credential stuffing attacks, this suite delivers an efficient way to manage a sea of data.

## :star2: Credits
This project is built upon the foundational work of ACCEIS' LeakScraper. Visit their GitHub repository for more information : https://github.com/Acceis/leakScraper

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
When Leaky requires your leak file content in the **email:password** format. Follow these steps:

```bash
# escape weird characters from your txt file
python3 clean-file.py -i <input_file> -o <output_file>

# import the file into mongodb (not mandatory you can do it on the web)
python3 import.py <file> <leak_name> <leak_date>

# start web instance on port 9999 ; default password -> leaky123
python3 scraper.py
```
### :mag_right: Functionalities
Leaky provides the following capabilities:

* **Search** :
   * Domain names or individuals
   * Phone numbers
   * Through JSON, CSV and SQL files
* **List of Leaks** : Access the directory of leaks (includes name, number of credentials, date, remove).
* **Upload** : Integrate your own leak file into the mongodb instance and watch it reflect on the web service.
* **Links** : Useful links for data leaks.

### :camera: Screenshots

**Search Credentials :** 
![image](https://github.com/saladandonionrings/leaky/assets/61053314/a0885daa-2058-4bc6-a418-4780a9962b39)

**Search Phones :**
![image](https://github.com/saladandonionrings/leaky/assets/61053314/8816a200-06ab-4c1f-a244-15a3db6badce)

**Search SQL/JSON/CSV :**
![image](https://github.com/saladandonionrings/leaky/assets/61053314/3379147c-c416-45ab-abee-fbcbe28f6193)

**List of Leaks :**
![image](https://github.com/saladandonionrings/leaky/assets/61053314/e51f089a-b141-4e65-ad8a-35cf07ca8fe5)

**Upload :**
![image](https://github.com/saladandonionrings/leaky/assets/61053314/36c0078d-e0bd-443f-87fa-f7a16d11423e)

**Links :**
![image](https://github.com/saladandonionrings/leaky/assets/61053314/9f30ee77-2aa7-4c16-88d5-49bd3c56fbb9)

