import json
import os

from db import db
from db import User, Post
from flask import request
from flask import Flask

# define db filename
db_filename = "bear_market.db"
app = Flask(__name__)

# setup config
app.config["SQLALCHEMY_DATABASE_URI"] = f"sqlite:///{db_filename}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

# initialize app
db.init_app(app)
with app.app_context():
    db.create_all()

# generalized response formats
def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code

@app.route("/")
@app.route("/api/users/")
def get_users():
    return success_response([u.serialize() for u in User.query.all()])

@app.route("/api/posts/")
def get_posts():
    return success_response([p.serialize() for p in Post.query.all()])

@app.route("/api/posts/active/")
def get_active_posts():
    return success_response([p.serialize() for p in Post.query.filter_by(active=True)])


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)
