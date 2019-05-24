# CardSwipr
## Features
### Event Attendance
CardSwipr helps event organizers take attendance at meetings and events. Users log in via CAS and create and manage events. The day of an event, Attendees can swipe in via an easy interface using their Yale ID. The application looks up attendees and collects their information in a list. When the event ends, organizers can download a spreadsheet (.csv) of the attendees' information.

## Architecture
CardSwipr is meant to be deployed to Heroku with a PostgreSQL backend.

![Data Architecture Model](READMEImages/CardSwipr_Data_Model.png)

## Contributing
### Getting Started

### Using Docker:
This method requires Docker to be installed on your system. You can find information on that here: [TO DO]

```
# Clone the repo
git clone https://gitlab.com/yale-sdmp/cardswipr.git
cd cardswipr

# Set up environment variables
cp .env.example .env

# Fill out required ENV variables
Note: Make sure to uncomment the commented-out variables- these are needed exclusively for docker.

# Create the containers
docker-compose build
docker-compose up -d --force-recreate
```

#### Local installation:
Make sure to have the specified Ruby version installed on your machine. We suggest using either [rbenv](https://github.com/rbenv/rbenv) or [asdf](https://github.com/asdf-vm/asdf) if you need multiple concurrent versions of Ruby installed.

You will also need PostgreSQL installed on your machine.

```
# Clone the repo
git clone https://gitlab.com/yale-sdmp/cardswipr.git
cd cardswipr

# Configure the database
cp config/database.yml.example config/database.yml

# Set up environment variables
cp .env.example .env
# Fill out required ENV variables

./bin/setup
```

# About
## Support or Contact
If you have trouble or questions about this application, email the managers of the [Student Developer & Mentorship Program](http://yalestc.github.io) at `dev-mgt@yale.edu`.
