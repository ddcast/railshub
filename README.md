# railshub

Youearnedit-railshub is a YEI Ruby code challenge solution.

To help companies learn a little about how I work and write code in a Rails context, I spent a few hours on solving the code problem [here](https://github.com/youearnedit/yei_challenge_ruby). The solution provided in this project is a Rails app with an adapter for the GitHub API (v3, unauthenticated) that uses a HTTP library to make requests, a parser to handle the response data that is persisted into SQLite wrapped using ActiveRecord. To bring it all together, I built a small front-end app using AngularJS with webpack to manage its dependencies via the Rails asset pipeline.

### Dependencies

- Ruby >= 2.2.2
- Node.js >= 4.3.0 < 5.0.0 || >= 5.10
- Yarn ~1.3.2

### Confirm Your Environment

If you don't have a suitable version of Ruby (see above), install a recent version using `rvm`.

```
$ rvm install 2.3.3
```

If you don't have a suitable version of Node.js (see above), install a recent version using `nvm`.

```
$ nvm install v6
```

This project was bundled with Bundler `1.16.1`. Use this command to install Bundler. Note: You may need to `sudo`.

```
$ gem install bundler
```

Install Yarn.

```
$ brew install yarn
```

Note: If you are using Windows, use `npm` to install Yarn in global mode.


### Setup

After confirming your environment, follow these steps to set up the project.

Install Ruby dependencies.

```
$ bundle install
```

Install Node.js dependencies.

```
$ yarn
```

Create your database.

```
$ rake db:create
$ rake db:schema:load
```

Populate your database from the remote source (GitHub API).

```
$ rake railshub:update_issues
```

### Testing

Simply run the RSpec command to run the test suite.

```
rspec
```

### Development

After you've set up the project, you can run the server. Any changes to files in `app/javascript` will automatically recompile assets on your next request.

```
bundle exec rails s -p 3000
```

You can access the application at [http://localhost:3000/home](http://localhost:3000/home) once the server is up using the above command.

### Production

The Procfile in this project will help you easily deploy this application to Heroku. Simply set the following Heroku config vars and deploy the project files.

```
WEB_CONCURRENCY=3
RAILS_ENV=production
```
