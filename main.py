import pymysql
from flask import Flask, render_template, request, session, redirect, flash
from datetime import datetime
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
import json
from flask_mail import Mail
import os
import math

with open('config.json', 'r') as c:
    params = json.load(c)["params"]
app = Flask(__name__)
app.secret_key = 'my-secret-key'
app.config['UPLOAD_FOLDER'] = params["upload_location"]
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-pass']
)
mail = Mail(app)
if (params["local_server"]):
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]

db = SQLAlchemy(app)


pymysql.install_as_MySQLdb()


class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), unique=False, nullable=False)
    email = db.Column(db.String(20), unique=True, nullable=False)
    phone_num = db.Column(db.String(20), unique=True, nullable=False)
    msg = db.Column(db.String(50), unique=False, nullable=False)
    date = db.Column(db.String(20), unique=False, nullable=True)


class Posts(db.Model):
    # sno,title,content,slug,date
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), unique=False, nullable=False)
    slug = db.Column(db.String(21), unique=True, nullable=False)
    content = db.Column(db.String(120), unique=False, nullable=False)
    subtitle = db.Column(db.String(30), unique=False, nullable=False)
    date = db.Column(db.String(12), unique=False, nullable=True)
    img_file = db.Column(db.String(20), unique=False, nullable=True)


@app.route('/')
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts) / int(params['no_of_posts_home']))
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1
    page = int(page)
    posts = posts[(page - 1) * int(params['no_of_posts_home']): (page - 1) * int(params['no_of_posts_home']) + int(
        params['no_of_posts_home'])]
    
    if (page == 1):
        prev = "#"
        next = "/?page=" + str(page + 1)
    elif (page == last):
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


@app.route('/about')
def about():
    return render_template('about.html', params=params)


@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    if ('user' in session and session['user'] == params["username"]):
        posts = Posts.query.filter_by().all()           
        last = math.ceil(len(posts) / int(params['no_of_posts_dashboard']))
        page = request.args.get('page')
        if (not str(page).isnumeric()):
            page = 1
        page = int(page)
        posts = posts[(page - 1) * int(params['no_of_posts_dashboard']): (page - 1) * int(params['no_of_posts_dashboard']) + int(params['no_of_posts_dashboard'])]
        
        if (page == 1):
            show_prev="invisible"
            show_next=""
            prev = "/dashboard?page=" + str(page)
            next = "/dashboard?page=" + str(page + 1)
        elif (page == last):
            prev = "/dashboard?page=" + str(page - 1)
            next = "/dashboard?page=" + str(page)
            show_prev=""
            show_next="invisible"
        else:
            prev = "/dashboard?page=" + str(page - 1)
            next = "/dashboard?page=" + str(page + 1)
            show_prev=""
            show_next=""

        return render_template("dashboard.html", params=params, posts=posts, prev=prev, next=next, show_prev= show_prev, show_next = show_next  )
    try:
        if request.method == 'POST':
            uname = request.form.get('uname')
            upass = request.form.get('upass')
            if uname == params["username"] and upass == params["userpass"]:
                session['user'] = uname
                posts = Posts.query.filter_by().all()           
                last = math.ceil(len(posts) / int(params['no_of_posts_dashboard']))
                num = request.args.get('page')
                if (not str(num).isnumeric()):
                    num = 1
                num = int(num)
                posts = posts[(num - 1) * int(params['no_of_posts_dashboard']): (num - 1) * int(params['no_of_posts_dashboard']) + int(params['no_of_posts_dashboard'])]
                
                if (num == 1):
                    prev = "#"
                    next = "/dashboard?num=" + str(page + 1)
                elif (num == last):
                    prev = "/dashboard?num=" + str(page - 1)
                    next = "#"
                else:
                    prev = "/dashboard?num=" + str(page - 1)
                    next = "/dashboard?num=" + str(page + 1)

                return render_template("dashboard.html", params=params, posts=posts, prev=prev, next=next)
    except:
        return render_template('signin.html', params=params)

    else:
        return render_template('signin.html', params=params)


@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if ('user' in session and session['user'] == params["username"]):
        if request.method == 'POST':
            title = request.form.get('title')
            subtitle = request.form.get('subtitle')
            slug = request.form.get('slug')
            content = request.form.get('content')
            image_file = request.form.get('image_file')
            date = datetime.now()
            if sno == '0':
                post = Posts(title=title, subtitle=subtitle, slug=slug,
                             content=content, img_file=image_file, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = title
                post.subtitle = subtitle
                post.content = content
                post.slug = slug
                post.img_file = image_file
                post.date = date
                db.session.commit()
            return redirect('/edit/'+sno)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template("edit.html", params=params, sno=sno, post=post)


@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params["username"]):
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(
                app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded successfully"


@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if ('user' in session and session['user'] == params["username"]):
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect("/dashboard")


@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route('/contact', methods=["GET", "POST"])
def contact():
    if (request.method == 'POST'):
        '''Add entry to the database'''
        try:
            name = request.form.get('name')
            email = request.form.get('email')
            message = request.form.get('message')
            phone = request.form.get('phone')
            entry = Contacts(name=name, email=email,
                             phone_num=phone, msg=message, date=datetime.now())
            db.session.add(entry)
            db.session.commit()
            mail.send_message('New mesage from Blog ' + "by " + name,
                              sender=email,
                              recipients=[params["gmail-user"]],
                              body=message + "\n" + "phone- " + phone)
            mail.send_message('Thanks for contacting us ',
                              sender=params["gmail-user"],
                              recipients=[email],
                              body="Thanks for being familiar with team Mr.Vinayak Singoriya"
                              )
            flash(
                "Thanks for submitting your details, we will get back to you soon.", "success")
        except:
            flash("Something went wrong.please check your internet connectivity and in case if it doesn't work, get in touch with our social media contact. ", "warning")

    return render_template('contact.html', params=params)


app.run(debug=True)
