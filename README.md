# leaky :key:
[![Python 3.5|3.6](https://img.shields.io/badge/python-3.x-green.svg)](https://www.python.org/) 
[![License](https://img.shields.io/badge/license-GPLv3-red.svg)](https://raw.githubusercontent.com/almandin/fuxploider/master/LICENSE.md)

Leaky is a potent arsenal of tools designed for parsing and visualizing colossal text files laden with credentials. Built with the goal to aid penetration testers and redteamers in OSINT, credentials gathering, and credential stuffing attacks, this suite delivers an efficient way to manage a sea of data.

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
Leaky requires your leak file content in the **email:password** format. Follow these steps:

```bash
# escape weird characters
python3 clean-file.py -i <input_file> -o <output_file>

# change creds for users in db-users.py ; default : admin:admin
python3 db-users.py 

# import the file into mongodb
python3 import.py <file> <leak_name> <leak_date>

# start web instance on port 9999
python3 scraper.py
```
### :mag_right: Functionalities
Leaky provides the following capabilities:

* **Search** : Find domain names or individuals.
* **List of Leaks** : Access the directory of leaks (includes name, number of credentials, date, remove).
* **Upload** : Integrate your own leak file into the mongodb instance and watch it reflect on the web service.

### :camera: Screenshots

**Search :** 
![image](https://github.com/saladandonionrings/leaky/assets/61053314/c225cbde-fa3b-4f4d-a04a-9ac8d567a569)

**List of Leaks :**
![image](https://github.com/saladandonionrings/leaky/assets/61053314/8080b131-e49a-4d03-a3fc-e83a9685d40b)

**Upload :**
![image](https://github.com/saladandonionrings/leaky/assets/61053314/148c4b71-e1af-4f29-962e-ef604cb2c2a1)


## :star2: Credits
This project is built upon the foundational work of ACCEIS' LeakScraper. Visit their GitHub repository for more information : https://github.com/Acceis/leakScraper
