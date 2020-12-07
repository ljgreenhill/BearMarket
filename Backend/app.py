import json
import os
from db import db
from db import User, Post, Conversation, Message
from flask import Flask, redirect, request, url_for
from oauthlib.oauth2 import WebApplicationClient
import requests
from flask_login import (
    LoginManager,
    current_user,
    login_required,
    login_user,
    logout_user,
    UserMixin
)

# define db filename
db_filename = "bear_market.db"
app = Flask(__name__)

app.secret_key = os.urandom(24)

# setup config
app.config["SQLALCHEMY_DATABASE_URI"] = f"sqlite:///{db_filename}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

#Google login
GOOGLE_CLIENT_ID = os.environ.get("GOOGLE_CLIENT_ID", None)
GOOGLE_CLIENT_SECRET = os.environ.get("GOOGLE_CLIENT_SECRET", None)
GOOGLE_DISCOVERY_URL = ("https://accounts.google.com/.well-known/openid-configuration")

#login manager to get current user
login_manager = LoginManager()
login_manager.init_app(app)

# initialize app
db.init_app(app)
with app.app_context():
    db.create_all()

# OAuth 2 client setup
client = WebApplicationClient(GOOGLE_CLIENT_ID)

def get_google_provider_cfg():
    return requests.get(GOOGLE_DISCOVERY_URL).json()

@login_manager.user_loader
def get_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response('User not found')
    else:
        return user

# generalized response formats
def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code

#all Google OAuth code from https://realpython.com/flask-google-login/----------------------------
@app.route("/")
def login():
    google_provider_cfg = get_google_provider_cfg()
    authorization_endpoint = google_provider_cfg["authorization_endpoint"]
    request_uri = client.prepare_request_uri(
        authorization_endpoint,
        redirect_uri=request.base_url + "callback",
        scope=["openid", "email", "profile"],
    )
    return redirect(request_uri)

@app.route("/callback")
def callback():
    code = request.args.get("code")
    google_provider_cfg = get_google_provider_cfg()
    token_endpoint = google_provider_cfg["token_endpoint"]
    token_url, headers, body = client.prepare_token_request(
        token_endpoint,
        authorization_response=request.url,
        redirect_url=request.base_url,
        code=code
    )
    token_response = requests.post(
        token_url,
        headers=headers,
        data=body,
        auth=(GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET),
    )
    client.parse_request_body_response(json.dumps(token_response.json()))
    userinfo_endpoint = google_provider_cfg["userinfo_endpoint"]
    uri, headers, body = client.add_token(userinfo_endpoint)
    userinfo_response = requests.get(uri, headers=headers, data=body)
    if userinfo_response.json().get("email_verified"):
        unique_id = userinfo_response.json()["sub"]
        users_email = userinfo_response.json()["email"]
        picture = userinfo_response.json()["picture"]
        users_name = userinfo_response.json()["given_name"]
    else:
        return failure_response('Email not authenticated by Google')
    user = User.query.filter_by(id=unique_id).first()
    if user is None:
        user = User(id=unique_id, name=users_name, email=users_email, profile_pic=picture)
    db.session.add(user)
    db.session.commit()
    login_user(user)
    return success_response(user.serialize(), 201)
#-------------------------------------------------------------------------------------------------

#user routes
@app.route("/logout")
def logout():
    logout_user()
    return success_response("Logged out", 201)

@app.route("/users/")
def get_users():
    return success_response([u.serialize() for u in User.query.all()])

@app.route("/users/", methods=["POST"])
def create_user():
    body = json.loads(request.data)
    if(body.get('email') is None):
        return failure_response('No email provided')
    new_user = User(id=body.get('id'),email=body.get('email'), bio=body.get('bio'))
    db.session.add(new_user)
    db.session.commit()
    return success_response(new_user.serialize(), 201)

@app.route("/users/current/")
def get_current_user():
    return success_response(current_user.serialize())

@app.route("/users/<string:user_id>/")
def get_specific_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response('User not found')
    return success_response(user.serialize())

@app.route("/users/<string:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response('User not found')
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())

#post routes
@app.route("/posts/")
def get_posts():
    return success_response([p.serialize() for p in Post.query.all()])

@app.route("/posts/active/")
def get_active_posts():
    return success_response([p.serialize() for p in Post.query.filter_by(active=None)])

@app.route("/posts/", methods=["POST"])
def create_post():
    body = json.loads(request.data)
    if(body.get('title') is None):
        return failure_response('No title provided')
    new_post = Post(title=body.get('title'), description=body.get('description'), seller=current_user.id)
    db.session.add(new_post)
    db.session.commit()
    return success_response(new_post.serialize(), 201)

@app.route("/posts/buy/<int:post_id>/", methods=["POST"])
def buy_item(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is None:
        return failure_response('Item not found')
    if post.active != None:
        return failure_response('Item inactive')
    post.active = False
    post.buyer.append(current_user)
    db.session.commit()
    return success_response(post.serialize())

@app.route("/posts/<int:post_id>/", methods=["DELETE"])
def delete_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is None:
        return failure_response('Post not found')
    db.session.delete(post)
    db.session.commit()
    return success_response(post.serialize())

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='127.0.0.1', port=port, ssl_context='adhoc')
