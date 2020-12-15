## Backend Description
- Google login using OAuth 2.0
  - Allows app to use LoginManager to get the current user
  - Frontend does not have to pass in who the current user is
- Images 
  - Frontend passes Base64 string when created post
  - Images are stored using AWS
- Uses Heroku Automated Certificate Management
- Database models used:
  - Many to many
    - Interested users to posts
  - One to many 
    - Seller to post 
    - Buyer to post
- API: https://documenter.getpostman.com/view/12799752/TVmV5DRu
- Link: https://bear-market.herokuapp.com/

## Frontend Description
- Google login using GoogleSignIn cocoapod upon entering the app
  - Theoretically allows users to see the posts that they personally are selling, are interested in, and 
- After login, must click "Done" in top left cornder to be led to a screen that prompts user to press button that enters into app
- Uses Alamofire to Get and Post information on users and posts
View Controllers:
- Bar at bottom to navigate between Home, New Post, and Me pages
- Home page
  - Post Collection View: 
    - Each cell is a post, and displays information on the item:
      - Seller: Includes seller's name, profile pic, and email
      - Item info: Picture of item, title of item, description
- New Post page
  - The user fills in a title, a description, a price, and (theoretically) an image of item
  - The information is (theoretically) posted to server, and a new post is created
- Me page
  - Does not yet function
  - Allows user to see their own profile, including their profile pic, 
  - UITableView (theoretically) allows user to look at posts they are Selling, Buying, and Interested in
  - UICollectionView shows posts 
- Post page
  - Opens upon selecting a Post Collection View Cell, and contains additional information about post:
    - Comments: Not yet functional, but users can leave comments on post 
 
