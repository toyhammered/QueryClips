# QueryClips

QueryClips is a simple, powerful, open-source data querying service.

# Features

### Write queries & save their results

![](https://www.dropbox.com/s/9j8zykfhoezu6zk/Screenshot%202016-04-10%2014.30.22.png?dl=1)

### Configure multiple database connections

![](https://www.dropbox.com/s/cb4arilwmyp5i68/Screenshot%202016-04-10%2014.33.58.png?dl=1)

### Export data to CSV and JSON

![](https://www.dropbox.com/s/iqttwtfypf28b6m/Screenshot%202016-04-10%2014.30.42.png?dl=1)

![](https://www.dropbox.com/s/h2lp8uavkxm9atm/Screenshot%202016-04-10%2014.31.30.png?dl=1)

### Visualizations (still in prototype phase)

![](https://www.dropbox.com/s/h5736by1pg3r536/Screenshot%202016-04-10%2014.31.12.png?dl=1)

### Simple & easy self-hosting

(See "Deploying to Heroku" section below.)

# Roadmap

In the short term, we aim to provide:

- Developer-friendly visualizations
- User accounts

# Starmap

In addition to our short term plans to allow simple querying and sharing, we aim to ultimately provide:

- A visually pleasing query experience
- A powerful point-and-click query editor
- Pivoting and drilling into data
- Comprehensive data exporting
- Mechanism for organizing queries
- A chat bot for quick access to your queries
- A hosted version of QueryClips for teams that don't wish to host their own instances
- Dashboards
- Reports by email

# Running QueryClips

## Deploying to Heroku

Click this button: [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/dpaola2/QueryClips)

This will deploy a free heroku application with a hobby Postgresql addon.

## Protecting your instance

Until user accounts exist, you can protect your instance by setting two environment variables: `BASIC_AUTH_USERNAME` and `BASIC_AUTH_PASSWORD`. You can do this on heroku through the dashboard or by running:

`$ heroku config:set BASIC_AUTH_USERNAME=alice BASIC_AUTH_PASSWORD=password`

## Updating

If you used the Heroku deploy button to deploy QueryClips, you will need to take the following steps the first time you update:

1. Clone the repository: `git clone git@github.com:dpaola2/QueryClips.git`
2. CD into the repository: `cd Duplo`
3. Log into your heroku dashboard and find the git URL for the heroku app that corresponds to your instance. Then, run `git remote add <heroku git url>`

Then, whenever you want to update, you simply:

1. `git pull origin master`
2. `git push heroku master`
3. `heroku run rake db:migrate`

# Usage

## Database Credentials

Convention suggests using read-only credentials for any database connections within QueryClips, thus preventing users from accidentally or maliciously making changes to your database. If you're managing your own Postgresql, here's how you can create a new read-only database user:

```
CREATE USER queryclips ENCRYPTED PASSWORD 'password';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO queryclips;
GRANT CONNECT ON database my_database TO queryclips;
GRANT USAGE ON SCHEMA public TO queryclips;
```

## Heroku Postgres

If you're using Heroku's managed Postgresql service, you should [create a read-only follower](https://devcenter.heroku.com/articles/heroku-postgres-follower-databases) to your database and tell QueryClips to connect to that database instead.

# Dev Installation

## Requirements:

- Rails 4.1
- Ruby 2.1.0
- Postgres 9.4.4

## Instructions

1. Clone the repo: `git clone git@github.com:dpaola2/QueryClips.git`
2. Create your database: `createdb queryclips_development`
3. Bundle install: `bundle install`
4. Run migrations: `bin/rake db:migrate`
5. Run the server: `foreman start`
6. Hit `localhost:3000` in your browser.

# Feature Requests

Please open an github issue to request a feature.

# Contributing

Contributions are welcome! Use pull requests. A great way to get started is to improve documentation or pick an "enhancement" issue and comment on the issue with your intention to contribute to it.

# License

QueryClips is licensed under the Apache 2.0 licence. See [LICENSE](LICENSE) for details.

