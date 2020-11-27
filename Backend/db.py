from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

db = SQLAlchemy()

association_post_buyer = db.Table(
    'association_post_buyer', 
    db.Model.metadata,
    db.Column('post_id', db.Integer, db.ForeignKey('post.id')),
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'))
)

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
    images = db.Column(db.String, nullable=True)
    title = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=True)
    buyers = db.relationship('User', secondary=association_post_buyer, back_populates='buyer_posts')
    seller = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)    
    interested = db.relationship('User', secondary=association_post_interested, back_populates='interested_posts')

    def __innit__(self, **kwargs):
        self.active = True
        self.title = kwargs.get('title', '')
        self.description = kwargs.get('description', '')
        self.seller = kwargs.get('seller')
    
    def serialize(self):
        return {
            'id': self.id,
            'title': self.title,
            'description': self.description,
            'active': self.active
        }

class User(db.Model, UserMixin):
    __tablename__='user'
    id = db.Column(db.String, primary_key = True)
    name = db.Column(db.String, nullable=True)
    email = db.Column(db.String, nullable=False)
    profile_pic = db.Column(db.String, nullable=True)
    
    bio = db.Column(db.String, nullable=True)
    seller_posts = db.relationship('Post', cascade='delete')
    buyer_posts = db.relationship('Post', secondary=association_post_buyer, back_populates='buyers')
    interested_posts = db.relationship('Post', secondary=association_post_interested, back_populates='interested')

    def __innit__(self, **kwargs):
        self.id = kwargs.get('id', '')
        self.email = kwargs.get('email', '')
        self.bio = kwargs.get('bio', '')

    def serialize(self):
        interested = []
        bought = []
        sold = []
        selling = []
        for post in self.interested_posts and post.serialize().get('active') is None:
            interested.append(post.serialize())
        for post in self.seller_posts:            
            if post.serialize().get('active') is None:
                selling.append(post.serialize())
            else:
                sold.append(post.serialize())
        for post in self.buyer_posts:
            if not post.serialize().get('active'):
                bought.append(post.serialize())
        return {
            'id': self.id,
            'email': self.email,
            'bio': self.bio,
            'interested': interested,
            'selling': selling,
            'sold': sold,
            'bought': bought
        }

class Conversation(db.Model):
    __tablename__ = 'conversation'
    id = db.Column(db.Integer, primary_key = True)
    this_user = db.Column(db.String, nullable = False)
    other_user = db.Column(db.String, nullable = False)
    messages = db.relationship('Message', cascade='delete')

    def __innit__(self, **kwargs):
        self.this_user = kwargs.get('this_user', '')
        self.other_user = kwargs.get('other_user', '')
        
    def serialize(self):
        messages_from_user = []
        messages_to_user = []
        for message in self.messages:
            if message.sender == self.this_user.id:
                messages_from_user.append(message)
            else:
                messages_to_user.append(message)
        return {
            'id': self.id,
            'this_user': self.this_user,
            'other_user': self.other_user,
            'messages_from_user': messages_from_user,
            'messages_to_user': messages_to_user
        }

class Message(db.Model):
    __tablename__ = 'message'
    id = db.Column(db.Integer, primary_key = True)
    sender = db.Column(db.String, nullable = False)
    receiver = db.Column(db.String, nullable = False)
    contents = db.Column(db.String, nullable = False)

    conversation_id = db.Column(db.Integer, db.ForeignKey('conversation.id'), nullable=False)

    def __innit__(self, **kwargs):
        self.sender = kwargs.get('sender', '')
        self.receiver = kwargs.get('receiver', '')
        self.contents = kwargs.get('contents', '')

    def serialize(self):
        return {
            'id': self.id,
            'sender': self.sender,
            'receiver': self.receiver,
            'contents': self.contents
        }
    

    


