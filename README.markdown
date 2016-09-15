[![Build Status](https://travis-ci.org/sonalkr132/cat-forum.svg?branch=github_master)](https://travis-ci.org/sonalkr132/cat-forum)

# CAT FORUM
CAT forum is the content management system for MNTC's CAT Forum, a web application aimed as a Forum for CAT preparations. We are currently using heroku for deployment.

It is written in Ruby on Rails and uses a Bootstrap based UI. We have recently added `haml` to our codebase as the HTML templating engine. Though some templates are still written in simple HTML but we will soon change them to HAML code. So please use HAML while writing template code. You can learn HAML from the [HAML Tutorial](http://haml.info/tutorial.html) or [HAML documentation](http://haml.info/docs/yardoc/file.REFERENCE.html). Some key features of CAT-Forum include:

* Posting and editing threads. We are using in place editing using the `best_in_place` gem
* An upvoting and commenting system
* User reputation system
* User profile and activity tracking using `public_activity` gem
* User login and authentication using `devise` gem and facebook login using `omniauth-facebook`
* A loose search interface using the `pg_search` gem. But we are thinking of switching to Sphinx or Solr

# Prerequisites

## Ruby
You can use any Ruby managers for Ruby management. Our preferred way is using **RVM** (https://rvm.io/). Install rvm along with Ruby using these command

 * `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
 * `\curl -sSL https://get.rvm.io | bash -s stable --ruby`

 **Ubuntu users:** You may need to enable `Run command as a login shell` in Ubuntu's Terminal, under _Edit > Profile Preferences > Title and Command_. Then close the terminal and reopen it. You may also want to run `source ~/.rvm/scripts/rvm` to load RVM.

## Database
We are using PostgreSQL database both in production and development. You also need to install the PostgreSQL dev package that will be needed by the `pg` gem

* For Debian/Ubuntu: `sudo apt-get install postgresql postgresql-contrib libpq-dev`
* Fedora/Red Hat/CentOS: `sudo yum install postgresql-server postgresql-contrib postgresql-devel`
* Mac OS X (using brew): `brew install postgres`

## Image uploads
We are using cloudinary as a cloud storage for images. So signup for a cloudinary account so that you can get the cloud name, api key and secret. We are using `carrierwave` to manage uploads to cloudinary.

# DEPLOYMENT

* We have all our secrets in secret.yml.example. You only need to rename it to secret.yml and fill in the secrets
* Use `rake secret` to generate the secret key, copy the generated key and paste it for `devise_key`. Do the same for `secret_key_base`. Enter the _cloud_name_, _api_key_ and _api_secret_ that you got from cloudinary in the `cloud_name`, `cloud_api_key` and `cloud_api_secret` fields
* If you would like to use fb login too then sign up with fb developers site, get your app key and app secret and paste it in `fb_app` and `fb_secret`
* Rename the database.rb.example file present in the config/initializers directory to database.rb
* For database settings you will have to fill in the username and password of your own local pg env.

# Running your local instance

* `cd` to app directory
* Run `bundle install` to install all the necessary gems
* For first time installation run `rake db:setup` to setup the database
* Start the server with `rails s`
* Go to `localhost:3000` in your broswer

## Using database migrations
What `rake db:setup` does is that it creates the development and test database using `rake db:create`, populates the database using the schema.rb file and then seeds the data using `rake db:seed`. When a new migration is introduced you don't need to run `rake db:setup` again, instead run `rake db:migrate` to run the migrations and update the database schema.

# Testing
Run tests using the command `rspec` or `bundle exec rspec`. We are using Rspec as our testing framework. Writing good tests ensure that all new features introduced don't break previous ones. So consider writing tests  whenever you work on new features.

# Ruby code analyzing using Rubocop
We are using Rubocop for code analyzing and lint-checking for Ruby. It follows the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide). Cleaner code is always easier to read and handle. So we are using Rubocop to encourage writing of cleaner code. Please run `rubocop` before submitting any code to check there are any lint errors and correct them according to the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide). Remember the travis-ci build will fail in case there are any lint errors.
