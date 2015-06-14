[![security](https://hakiri.io/github/sonalkr132/cat-forum/github_master.svg)](https://hakiri.io/github/sonalkr132/cat-forum/github_master)

## CAT FORUM
CAT forum tries to use the magic of internet to find all your answers. We are using heroku for deployment for now.

# DEPLOYMENT

We have all our secrets in secret.yml.example. You only need to rename it to secret.yml and fill in the secrets.

* sign up with cloudinary and get the cloudinary.yml file. Replace it with cloudinary.yml.example.
* Use `rake secret` to generate the secret key, copy the generated key and paste it for `devise_key`. Do the same for `secret_key_base`
* If you would like to use fb login too then sign up with fb developers site, get your app key and app secret and paste it in `fb_app` and `fb_secret`.
* Rename the devise.rb.example file present in the config/initializers directory to devise.rb . 
* Rename the production.rb.example file in config/environments directory to production.rb
* For db settings you will have to fill in the username and password of your own local env of mysql and pg.

# Running your local instance

* Start mysql or postgres and create database forum_development using command `CREATE DATABASE forum_development;`
* `cd` to app directory
* Run `bundle install` to install all the necessary gems
* Migrate the database with `rake db:migrate`
* Start the server with `rails s`
* Go to `localhost:3000` in your broswer.
