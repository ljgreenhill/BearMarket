from flask_sqlalchemy import SQLAlchemy

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
    active = db.Column(db.Boolean, default=True)
    #TODO item images
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

class User(db.Model):
    __tablename__='user'
    id = db.Column(db.Integer, primary_key = True)
    email = db.Column(db.String, nullable=False)
    bio = db.Column(db.String, nullable=True)
    #TODO: store image as profile_pic    
    seller_posts = db.relationship('Post', cascade='delete')
    buyer_posts = db.relationship('Post', secondary=association_post_buyer, back_populates='buyers')
    interested_posts = db.relationship('Post', secondary=association_post_interested, back_populates='interested')

    def __innit__(self, **kwargs):
        self.email = kwargs.get('email', '')
        self.bio = kwargs.get('bio', '')

    def serialize(self):
        interested = []
        bought = []
        sold = []
        selling = []
        for post in self.interested_posts and post.serialize().get('active'):
            interested.append(post.serialize())
        for post in self.seller_posts:            
            if(post.serialize().get('active')):
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
