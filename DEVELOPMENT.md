# Development Notes

## Set Up

### Client side certificates
You need a client-side SSL certificate to access the private API for
look-up. Contact YaleSTC to get the development certificate and key. Store the files in a secure and private location.

### Secret token
Use `rake secret` to generate your own secret key, and keep this private. It is probably not as important in the local development environment though.

### Database
Set up a local MySQL database to store events and entries information, and configure it in `config/database.yml`. See `config/database.yml.example` for a guideline.

### ServiceNow
You need a username and a password to access the ServiceNow API.
Again, contact YaleSTC to get them, and keep them private.

### Standard Rails Application Setup
```
bundle install
rake db:create
rake db:schema:load
rails server
```

Before running `rails server`, take a look at the following configuration files:
* `config/secrets.yml`
* `config/database.yml`
* `config/environments/production.yml`
* `config/environments/development.yml`
* `config/environments/local.yml`

You will see they are expecting several environment variables to be
set. See `local_env.example`.

## Testing
From the application root directory, do
```
bundle exec rspec
```
You could also run `guard` for continuous testing but since we switched to `selenium` as driver for Capybara in order for the server-side API calls to be waited on, it may it maybe cumbersome and slow.

## Application Structure
Each of the models have a comment above them explaining what the purpose of the model is.

## Pre-Pull-Request Code Quality Checks
Before submitting a pull request, please check on the following:

1. Does the testing suite pass? Run `guard` (see _Testing_ above), and press enter once to run the whole testing suite. Guard automatically runs tests on files you've changed, see `Guardfile` for its rules. You need also set environment variables before running the tests: again see `local_env.example`.
2. Have you added tests for any new features?
3. Have you corrected as many of pronto's suggestions as make sense? Run pronto with `bundle exec pronto run`. Pronto runs many code analyzers such as rubocop, brakeman, flay, and rails_best_practices - only on the code you've modified.
4. Does your pull request contain only relevant code changes?
