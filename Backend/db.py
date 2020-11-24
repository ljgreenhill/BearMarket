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

class Post(db.Model):
    __tablename__ = 'post'
    

class User(db.Model):
    __tablename__='user'
    id = db.Column(db.Integer, primary_key = True)
    username = db.Column(db.String, nullable=False)
    #TODO: store image as profile_pic
    username = db.Column(db.String, nullable=False)
    seller_posts = db.relationship('Post', secondary=association_post_seller, back_populates='sellers')
    buyer_posts = db.relationship('Post', secondary=association_post_buyer, back_populates='buyers')

    def __innit__(self, **kwargs):
        self.name = kwargs.get('name', '')
        self.netid = kwargs.get('netid', '')

    def serialize(self):
        return {
            'username': self.username,
            'bio': self.bio,
            'profile_pic': self.profile_pic,
            'password': self.password
        }
