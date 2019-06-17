# Development Notes

## Set Up

### Docker-compose

This app has been updated to use docker-compose. Make sure you have it installed.

To run this app locally you must copy `.env.example` to `.env` and set the environment variables.

After they have been set run `docker-compose build` followed by `docker-compose up -d` (possibly with the --force-recreate flag) to build the dockerfile and then run the application. It can be accessed through localhost:3000

### CAS base URL
The base CAS url used for authentication (probably https://secure.its.yale.edu/cas) 

### Secret key base
Use `rake secret` to generate your own secret key, and keep this private. It is probably not as important in the local development environment though.

### Rails ENV
Unique to this project is the "local" database configuration. Local testing requires the RAILS_ENV to be set to local (i.e. RAILS_ENV=local).

This variable can be set to `local, development, test, or production`

### ServiceNow
You need a username and a password to access the ServiceNow API. The SN_INSTANCE variable is the base for the service-now instance used by yale (probably https://yale.service-now.com but it may have changed).

### ID API
This variable references the identity server used to get user information.

## Testing
After running `docker-compose up -d` run
```
docker-compose run --rm web rspec
```