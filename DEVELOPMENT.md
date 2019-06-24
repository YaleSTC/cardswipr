# Development Notes

## Set Up

### Docker-compose

The recommended method for development is through [Docker Compose](https://docs.docker.com/compose/).

To run this app locally you must copy `.env.example` to `.env` and set the environment variables.

After they have been set run `docker-compose build` followed by `docker-compose up -d` (possibly with the --force-recreate flag) to build the dockerfile and then run the application. It can be accessed through localhost:3000

### CAS_BASE_URL
The base CAS url used for authentication (probably https://secure.its.yale.edu/cas) 

### SECRET_KEY_BASE
Use `rake secret` to generate your own secret key, and keep this private. It is probably not as important in the local development environment though.

### RAILS_ENV
Unique to this project is the "local" database configuration. Local testing requires the RAILS_ENV to be set to local (i.e. RAILS_ENV=local).

This variable can be set to `local, development, test, or production`

### ServiceNow
You need a username and a password to access the ServiceNow API. The SN_INSTANCE variable is the base for the service-now instance used by Yale (probably https://yale.service-now.com but it may have changed).

### ID_API
These variables references the identity server used to get user information.

#### ID_API_URL
This variable represents the URL that the identity server points to.

Production: https://gw.its.yale.edu/soa-gateway/v2/identity
Local/Test/Development: https://gw-dev.its.yale.edu/soa-gateway/v2/identity

### DATABASE_HOST

This variable references the host that runs your mysql instance. If using docker-compose set this to `database`. Additionally, you must give this database a username and password. Docker-compose will create a database for you if you give it any username and password.

## Testing
After running `docker-compose up -d` run
```
docker-compose run --rm web rspec
```