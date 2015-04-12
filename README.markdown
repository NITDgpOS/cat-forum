## CAT FORUM
CAT forum tries to use the magic of internet to find all your answers. We are using heroku for deployment for now.

# DEPLOYMENT

We have all our secrets in secret.yml.example. You only need to rename it to secret.yml and fill in the secrets.

* sign up with cloudnary and get the cloudanry.yml file. Replace if with cloudanry.yml.example.
* Use `rake secret` to generate the secret key, copy the generated key and paste it for `devise_key`. Do the same for `secret_key_base`
* If you would like to ise fb login too then sign up with fb developers site, get your app key and app secret and paste it in `fb_app` and `fb_secret`.
* For db settings you will have to fill in the username and password of your own local env of mysql and pg.

# Running your local instance

* Migrate the database with `rake:db:migrate`
* Start the server with `rails s`
* Go to `localhost:3000` in your broswer.

