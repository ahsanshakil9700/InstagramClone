# Instagram Clone

This app is built on ROR architecture. In order to clone this branch following requirements are necessary:

* Ruby Version: 2.7.6
* Rails Version 5.2.0

## Overview of the Schema:
The Application has following Tables:
* Account Model (This can be thought of as User Model)
* Posts Model
* Comment Model
* Likes Model
* Photos Model (Polymorphic Model)
* Stories Model
* Follow Model
* Request Model
* Application Model (Default ApplicationReccord)

The Photo model is polymorphic: Stories and Posts both inherit photos from the Photo Model.
As the name of 'User' model is not conventional, (this has been a mistake from the start but I have implemented the project accordingly), 
I have used certain functions to mould the standard 'current_user' function throughout the controllers. 

Application is based on following Gems:
* Cloudinary for Cloud Storage
* Carrierwave for easy upload of photos and avatars
* Bootstrap, Jquery and bootsnap
* Devise for authentication
* Pundit for authorization
* Whenever for CronJobs
* Figaro for hidden credentials
* Rubocop for code linting and format
* Pg for Database PostgreSql
* Some other rails specified gems

The Application can do the following controller wise:
### User
* SignIn / SignUp
* Follow Private and Public Accounts
* Create Posts with or without description but images must be present
* Create Stories that are visible for 24 hours
* View posts on the main feed of friends (Followed People)
* Edit their own posts
* Edit there own Profile
* Can have avatars
* Can set their account public or private (default: public)
* Like or Comment on the posts that appear on the feed.
* Delete their Posts, Stories or Likes (unlike)
* Delete their Account

### Posts
* Posts can have likes
* Posts can have comments
* Posts also have timestamps displayed
* Posts Content can be edited

### Stories
* Stories are for 24 hours and have delete options
