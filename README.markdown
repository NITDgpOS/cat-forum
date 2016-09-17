[![Build Status](https://travis-ci.org/sonalkr132/cat-forum.svg?branch=github_master)](https://travis-ci.org/sonalkr132/cat-forum)

# CAT FORUM
CAT forum is the content management system of MNTC's CAT Forum, a web forum for CAT preparations. We use  heroku for deployment.

It is written in Ruby on Rails and uses Bootstrap for UI design. We use `haml` as our HTML templating engine. Some legacy templates are written in simple HTML (PR please!). Please use HAML while writing template code. You can learn HAML from the [HAML Tutorial](http://haml.info/tutorial.html) or [HAML documentation](http://haml.info/docs/yardoc/file.REFERENCE.html). Some key features of CAT-Forum include:

* Posting and editing threads. We are using in place editing using the `best_in_place` gem
* An upvoting and commenting system
* User reputation system
* User profile and activity tracking using `public_activity` gem
* User login and authentication using `devise` gem and facebook login using `omniauth-facebook`
* A loose search interface using the `pg_search` gem.

# Prerequisites

## Ruby
You can use any Ruby managers for Ruby management. We use **RVM** (https://rvm.io/). Install rvm along with Ruby using these command

 * `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
 * `\curl -sSL https://get.rvm.io | bash -s stable --ruby`

 **Ubuntu users:** You may need to enable `Run command as a login shell` in Ubuntu's Terminal, under _Edit > Profile Preferences > Title and Command_. Close the terminal and reopen it. You may also want to run `source ~/.rvm/scripts/rvm` to load RVM.

## Database
We use PostgreSQL both in production and development. Please install the PostgreSQL dev package needed by the `pg` gem

* For Debian/Ubuntu: `sudo apt-get install postgresql postgresql-contrib libpq-dev`
* Fedora/Red Hat/CentOS: `sudo yum install postgresql-server postgresql-contrib postgresql-devel`
* Mac OS X (using brew): `brew install postgres`

## Image uploads
We use cloudinary as a cloud storage for images. Signup for a cloudinary account so that you can get the cloud name, api key and secret. We use `carrierwave` to manage uploads to cloudinary.

# DEPLOYMENT

* We have all our secrets in secret.yml.example. You only need to rename it to secret.yml and fill in the secrets
* Use `rake secret` to generate the secret key, copy the generated key and paste it for `devise_key`. Do the same for `secret_key_base`. Enter the _cloud_name_, _api_key_ and _api_secret_ that you got from cloudinary in the `cloud_name`, `cloud_api_key` and `cloud_api_secret` fields
* If you would like to use fb login too, sign up with fb developers site, get your app key and app secret and paste it in `fb_app` and `fb_secret`
* Rename the database.rb.example file present in the config/initializers directory to database.rb
* For database settings you will have to fill in the username and password of your own local pg env.

# Running your local instance

```
$ cd cat-forum
# install gems
$ bundle install
# setup the database
$ rake db:setup
# start rails server
$ rails s
```
Go to `localhost:3000` in your broswer. Congratulations! Now you are running on rails.

## Using database migrations
`rake db:setup` creates the development and test database using `rake db:create`, populates the database using the schema.rb file and seeds the data using `rake db:seed`. When a new migration is introduced you don't need to run `rake db:setup` again, instead run `rake db:migrate` to run the migrations and update the database schema.

# Testing
Run tests using the command `rspec` or `bundle exec rspec`. We are using Rspec as our testing framework. Writing good tests ensure that all new features introduced don't break previous ones. Please, write tests to explain the change you are suggesting.

# Ruby code analyzing using Rubocop
We use Rubocop for code analyzing and lint-checking for Ruby. It follows the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide). Cleaner code is always easier to read and handle. Please run `rubocop` before submitting any code for lint errors. You can correct them using [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide). The travis build will fail if there are any lint errors.
