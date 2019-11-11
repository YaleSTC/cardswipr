# Development Notes

## Set Up

### Local Development

Steps to run locally
1. Copy `.env.example` to `.env` and fill out the variables (See the variables enumerated below)
2. Run `rails s`
3. Access the site on `localhost:3000`

### Docker-compose Development

The recommended method for development is through [Docker Compose](https://docs.docker.com/compose/).

Steps to run using docker-compose
1. Copy `.env.example` to `.env`
2. Copy `deco.json.template` to `deco.json` and fill out the variables (See the variables enumerated below)
3. Run `docker-compose build`
4. Run `docker-compose up -d`
5. Access the site on `localhost:3000` - this may take time to build since the assets need to precompile on spinup

NOTE: If running this in production mode you may need to modify the `/config/environments/production.rb` and change `config.force_ssl` from true to false (otherwise you will need to set up SSL certificates locally).

## Variables

### CAS_BASE_URL
The base CAS url used for authentication.

### SECRET_KEY_BASE
Use `rake secret` to generate your own secret key, and keep this private. It is probably not as important in the local development environment though.

### RAILS_ENV
Unique to this project is the "local" database configuration. Local testing requires the RAILS_ENV to be set to local (i.e. RAILS_ENV=local).

This variable can be set to `local, development, test, or production`

### ServiceNow
You need a username and a password to access the ServiceNow API. The SN_INSTANCE variable is the base URL (`www.[...].com`) for the service-now instance.

### ID_API
These variables references the identity server used to get user information.

#### ID_API_URL
This variable represents the URL that the identity server points to.

### DATABASE & MYSQL Variables

These variables define database environment variables. For local docker-compose development set this section to

```
DATABASE_HOST=database
MYSQL_DATABASE=cardswipr_local
MYSQL_USER=root
MYSQL_PASSWORD=
```

## Testing
After running `docker-compose up -d` run
```
docker-compose run --rm web rspec
```

NOTE: ONLY RUN THIS WHILE CONNECTED TO A LOCAL DATABASE