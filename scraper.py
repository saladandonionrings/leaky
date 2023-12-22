from pymongo import MongoClient
from bottle import *
from passlib.hash import pbkdf2_sha256
import math
import re
import io
import datetime
import subprocess
import os
import time
import secrets
from math import ceil 

secret_key = secrets.token_hex(16) 

mongo_database = "DBleaks"

app = Bottle()

@app.route('/', method='GET')
@view('views/login.tpl')
def login():
    return template('login', failed=False)

@app.route('/login', method='POST')
@view('views/login.tpl')
def do_login():
    password = request.forms.get('password')
    
    if not password:
        return template('login', failed=True)

    client = MongoClient()
    db = client[mongo_database]
    access = db['access'].find_one({'type': 'admin_password'})
    
    stored_password = access.get('password') if access else None

    if not stored_password:
        return template('login', failed=True)

    if pbkdf2_sha256.verify(password, stored_password):
        print("Password verified, setting cookie and redirecting")
        response.set_cookie("authenticated", "true", secret=secret_key) 
        return redirect('/index')
    else:
        return template('login', failed=True)



def is_authenticated():
    auth_cookie = request.get_cookie("authenticated", secret=secret_key)
    print(f"Auth cookie: {auth_cookie}")
    if auth_cookie:  
        return True

@app.route('/logout')
def logout():
    response.delete_cookie('authenticated', secret=secret_key)
    redirect('/')


@app.route('/index', method='GET')
@view('views/index.tpl')
def index():
    if not is_authenticated():
        redirect('/')
    else:
        query = request.query.search
        domain_query = request.query.d
        name_query = request.query.p
        leak_name = request.query.leakname
        page_number = request.query.page or '1'
        try:
            page_number = int(page_number)
        except ValueError:
            page_number = 1

        page_size = 250

        client = MongoClient()
        db = client[mongo_database]
        credentials = db["credentials"]

        # Create text index
        credentials.create_index([("d", "text"), ("p", "text"), ("P", "text")])
        credentials.create_index([("date", 1)])

        query_conditions = {}

        if query:
            query_conditions["$text"] = {"$search": query}

        if domain_query:
            query_conditions["d"] = {"$regex": re.escape(domain_query)}

        if name_query:
            query_conditions["p"] = {"$regex": re.escape(name_query)}

        if leak_name:
            if leak_name == "All Leaks":
                query_conditions["leakname"] = {"$exists": True}
            else:
                query_conditions["leakname"] = leak_name

        creds = []
        nbRes = 0

        if query or domain_query or name_query or leak_name:
            skip = (page_number - 1) * page_size
            creds = [document for document in credentials.find(query_conditions).skip(skip).limit(page_size)]
            nbRes = credentials.count_documents(query_conditions)

        count = credentials.count_documents({})
        count = '{:,}'.format(count).replace(',', ' ')
        total_pages = ceil(nbRes / page_size)
        prevPage = max(1, page_number - 1)
        nextPage = page_number + 1
        distinct_dates = sorted(credentials.distinct("date"), reverse=True)

        return dict(
            creds=creds,
            count=count,
            query={
                "search": query,
                "d": domain_query,
                "p": name_query,
                "leakname": leak_name,
            },
            nbRes=nbRes,
            page=page_number,
            total=total_pages,
            prevPage=prevPage,
            nextPage=nextPage,
            distinct_dates=distinct_dates,
        )

@app.route('/leaks', method='GET')
@view('views/leaks.tpl')
def getLeaks():
    if not is_authenticated():
        redirect('/')
    else:
        client = MongoClient()
        db = client[mongo_database]
        credentials = db["credentials"]
        leaks = db["leaks"]
        count = credentials.count_documents({})
        count = '{:,}'.format(count).replace(',', ' ')
        nbLeaks = leaks.count_documents({})
        leaksa = []
        if nbLeaks > 0:
            for leak in leaks.find():
                leak_id = leak["id"]
                imported_count = credentials.count_documents({"l": leak_id})
                leak_info = {
                    "id": leak_id,
                    "imported": '{:,}'.format(int(imported_count)).replace(',', ' '),
                    "name": leak["name"],
                    "date": leak.get("date", "")  # Set date to empty string if missing
                }
                leaksa.append(leak_info)

        return dict(count=count, nbLeaks=nbLeaks, leaks=leaksa)

@app.route('/export', method='GET')
def export():
    if not is_authenticated():
        redirect('/')
    else:
        domain_query = request.query.d
        name_query = request.query.p

        if domain_query or name_query:
            client = MongoClient()
            db = client[mongo_database]
            credentials = db["credentials"]
            query_conditions = {}

            if domain_query:
                query_conditions["d"] = {"$regex": re.escape(domain_query)}

            if name_query:
                query_conditions["p"] = {"$regex": re.escape(name_query)}

            r = credentials.find(query_conditions)
            res = "\n".join([str(x["p"]) + "@" + str(x["d"]) + ":" + str(x["P"]) for x in r])

            output = io.BytesIO()
            output.write(res.encode('utf-8'))
            output.seek(0)

            response.content_type = 'application/force-download; UTF-8'
            response.set_header("Content-Disposition", "attachment;filename=creds-" + (domain_query or name_query) + ".txt")

            return output
        else:
            redirect("/")

@app.route('/removeLeak', method='GET')
def removeLeak():
    if not is_authenticated():
        redirect('/')
    else:
        if request.query.id:
            client = MongoClient()
            db = client[mongo_database]
            credentials = db["credentials"]
            leaks = db["leaks"]
            print("\tRemoving credentials for leak " + str(request.query.id) + " ...")
            credentials.delete_many({"l": int(request.query.id)})
            leaks.delete_one({"id": int(request.query.id)})
            print("\tdone.")
        redirect("/leaks")

@app.route('/upload', method='GET')
@view('views/upload.tpl')
def upload_form():
    if not is_authenticated():
        redirect('/')
    else:
        return {}

def run_leak_importer(filepath, leak_name, leak_date):
    cmd = ["python3", "import.py", filepath, leak_name, leak_date]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    log_filename = "leak_import.log"
    upload_folder = "uploads"
    log_path = os.path.join(upload_folder, log_filename)

    with open(log_path, "w") as log_file:
        while proc.poll() is None:
            stdout = proc.stdout.readline()
            stderr = proc.stderr.readline()

            log_file.write(stdout.decode())
            log_file.write(stderr.decode())

    stdout, stderr = proc.communicate()
    stdout = stdout.decode()
    stderr = stderr.decode()

    with open(log_path, "a") as log_file:
        log_file.write(stdout)
        log_file.write(stderr)

    os.remove(filepath)


@app.route('/upload', method='POST')
@view('views/upload.tpl')
def upload_file():
    if not is_authenticated():
        redirect('/')
    else:
        leak_name = request.forms.get('leakName')
        leak_date = request.forms.get('leakDate')
        upload = request.files.get('file')
        upload_folder = "uploads"
        filepath = os.path.join(upload_folder, upload.filename)
        upload.save(filepath, overwrite=True)

        uploader = threading.Thread(target=run_leak_importer, args=(filepath, leak_name, leak_date))
        uploader.start()

        return {}
@app.route('/links-directory', method='GET')
@view('views/links.tpl')
def link_directory():
    if not is_authenticated():
        redirect('/')
    links = [
        {"title": "HIBP", "url": "https://haveibeenpwned.com/"},
        {"title": "Intelligence X", "url": "https://intelx.io/"},
        {"title": "search.0t.rocks", "url": "https://search.0t.rocks/"},
        # Add more links as needed
    ]

    return dict(links=links)

@app.route('/static/css/<filename:path>')
def send_static_css(filename):
    print(f"Requested CSS file: {filename}")  # Debug print
    return static_file(filename, root='./views/css/')


@app.route('/static/js/<filename:path>')
def send_static_js(filename):
    return static_file(filename, root='./views/js/')

@app.hook('before_request')
def enable_protection():
    response.headers['Strict-Transport-Security'] = 'max-age=31536000; includeSubDomains'
    response.headers['Server'] = 'Leaky'
    response.headers['X-Powered-By'] = 'Leaky'

run(app=app, host="127.0.0.1", port=9999)
