from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
import base64
import boto3
import datetime
from io import BytesIOI
from mimetypes import guess_extension, guess_type
import os
from PIL import Image
import random
import re
import string

db = SQLAlchemy()

EXTENSIONS = ["png", "gif", "jpg", "jpeg"]
BASE_DIR = os.getcwd()
S3_BUCKET = "cornellebay"
S3_BASE_URL = f"https://{S3_BUCKET}.s3-us-east-2.amazonaws.com"

class Asset(db.Model):
    __tablename__ = "image"

    id = db.Column(id.Integer, primary_key=True)
    base_url = db.Column(db.String, nullable=False)
    salt = db.Column(db.String, nullable=False)
    extension = db.Column(db.String, nullable=False)
    post_id = db.Column(db.Integer, db.ForeignKey('post.id'), unique=True)

    def __init__(self, **kwargs):
        self.create(kwargs.get("image_data"))

    def serialize(self):
        return{
            "url": f"{self.base_url}/{self.salt}.{self.extension}"
        }

    def create(self, image_data):
        try:
            ext = guess_extension(guess_type(image_data)[0])[1:]
            if ext not in EXTENSIONS:
                raise Exception(f"Extension {ext} not supported!")
            salt = "".join(
                random.SystemRandom().choice(
                    string.ascii_uppercase + string.digits
                )
                for _ in range(16)
            )
            img_str = re.sub("^data:image/.+;base64,", "", image_data)
            img_data = base64.b64decode(img_str)
            img = Image.open(BytesIOI(img_data))
            self.base_url = S3_BASE_URL
            self.salt = salt
            self.extension = ext
            img_filename = f"{salt}.{ext}"
            self.upload(img, img_filename)
        except Exception as e:
            print(f"Unable to create image due to {e}")
    
    def upload(self, img, img_filename):
        try:
            img_temploc = f"{BASE_DIR}/{img_filename}"
            img.save(img_temploc)
            s3_client = boto3.client("s3")
            s3_client.upload_file(img_temploc, S3_BUCKET, img_filename)
            s3_resource = boto3.resource("s3")
            object_acl = s3_resource.ObjectAcl(S3_BUCKET, img_filename)
            object_acl.put(ACL="public-read")
            os.remove(img_temploc)
        except Exception as e:
            print(f"Unable to create image due to {e}")



association_post_interested = db.Table(
    'association_post_interested', 
    db.Model.metadata,
    db.Column('post_id', db.Integer, db.ForeignKey('post.id')),
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'))
)

class Post(db.Model):
    __tablename__ = 'post'
    id = db.Column(db.Integer, primary_key = True)
    active = db.Column(db.Boolean, nullable=True)
    price = db.Column(db.String, nullable=False)

    image = db.relationship('Asset', backref='post', uselist=False)


    title = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=True)
    buyer = db.Column(db.String, db.ForeignKey('user.id'))  
    seller = db.Column(db.String, db.ForeignKey('user.id'), nullable=False)  
    interested = db.relationship('User', secondary=association_post_interested, back_populates='interested_posts')
    comments = db.relationship('Comment', cascade='delete')

    def __init__(self, **kwargs):
        self.active = True
        self.title = kwargs.get('title')
        self.description = kwargs.get('description', '')
        self.seller = kwargs.get('seller')
        self.price = kwargs.get('price')
    
    def serialize(self):
        comments = []
        if self.comments:
            for comment in self.comments:
                comments.append(comment.serialize())
        else:
            comments = None
        return {
            'id': self.id,
            'title': self.title,
            'description': self.description,
            'active': self.active,
            'price': self.price,
            'seller': self.seller,
            'buyer': self.buyer,
            'image': self.image.serialize(),
            'comments': comments
        }

class User(db.Model, UserMixin):
    __tablename__='user'
    id = db.Column(db.String, primary_key = True)
    name = db.Column(db.String, nullable=True)
    email = db.Column(db.String, nullable=False)
    profile_pic = db.Column(db.String, nullable=True)
    seller_posts = db.relationship('Post', foreign_keys=[Post.seller], cascade='delete')
    buyer_posts = db.relationship('Post', foreign_keys=[Post.buyer], cascade='delete')
    interested_posts = db.relationship('Post', secondary=association_post_interested, back_populates='interested')

    def __init__(self, **kwargs):
        self.id = kwargs.get('id', '')
        self.email = kwargs.get('email', '')
        self.name = kwargs.get('name', '')
        self.profile_pic = kwargs.get('profile_pic', '')

    def serialize(self):
        interested = []
        bought = []
        sold = []
        selling = []
        for post in self.interested_posts:
            if post.serialize().get('active') is None or post.serialize().get('active') == True:
                interested.append(post.serialize())
        for post in self.seller_posts:            
            if post.serialize().get('active') is None or post.serialize().get('active')==True:
                selling.append(post.serialize())
            else:
                sold.append(post.serialize())
        for post in self.buyer_posts:
            if not post.serialize().get('active'):
                bought.append(post.serialize())
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'profile_pic': self.profile_pic,
            'interested': interested,
            'selling': selling,
            'sold': sold,
            'bought': bought
        }

class Comment(db.Model):
    __tablename__='comment'
    id = db.Column(db.Integer, primary_key = True)
    sender = db.Column(db.String, nullable=False)
    content = db.Column(db.String, nullable=False)
    post = db.Column(db.Integer, db.ForeignKey('post.id'), nullable=False)  

    def __init__(self, **kwargs):
        self.sender = kwargs.get('sender')
        self.content = kwargs.get('image')
        self.post = kwargs.get('post')

    def serialize(self):
        return {
            'id': self.id,
            'sender': self.sender,
            'content': self.content,
        }








    


