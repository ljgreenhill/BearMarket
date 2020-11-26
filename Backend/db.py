from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

association_post_seller = db.Table(
    'association_post_seller', 
    db.Model.metadata,
    db.Column('post_id', db.Integer, db.ForeignKey('post.id')),
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'))
)

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
    active = (db.Boolean, nullable=True)
    #TODO item images
    title = (db.String, nullable=False)
    description = (db.String, nullable=True)

    def __innit__(self, **kwargs):
        self.active = False
        self.title = kwargs.get('title', '')
        self.description = kwargs.get('description', '')
    
    def serialize(self):
        return {
            'title': self.title,
            'description': self.description
        }

class User(db.Model):
    __tablename__='user'
    id = db.Column(db.Integer, primary_key = True)
    email = db.Column(db.String, nullable=False)
    bio = (db.String, nullable=True)
    #TODO: store image as profile_pic
    seller_posts = db.relationship('Post', secondary=association_post_seller, back_populates='sellers')
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

        for post in self.interested_posts:
            interested.append(post.serialize())
        for post in self.seller_posts:
            if(post.serialize().get('active')):
                selling.append(post)
            else:
                sold.append(post)
        for post in self.buyer_posts:
            if not post.serialize().get('active'):
                bought.append(post)

        return {
            'email': self.email,
            'bio': self.bio
        }
