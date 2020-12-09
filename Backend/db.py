from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

db = SQLAlchemy()

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
    image = db.Column(db.String, nullable=True)
    title = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=True)
    buyer = db.Column(db.Integer, db.ForeignKey('user.id'))  
    seller = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)  
    interested = db.relationship('User', secondary=association_post_interested, back_populates='interested_posts')
    comments = db.relationship('Comment', cascade='delete')

    def __init__(self, **kwargs):
        self.active = True
        self.title = kwargs.get('title')
        self.description = kwargs.get('description', '')
        self.seller = kwargs.get('seller')
        self.image = kwargs.get('image')
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
            'image': self.image,
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
    sender = db.Column(db.String, nullable=True)
    content = db.Column(db.String, nullable=True)
    post = db.Column(db.Integer, db.ForeignKey('post.id'), nullable=False)  






    


