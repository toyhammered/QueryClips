# QueryClips

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/dpaola2/QueryClips)

QueryClips is an easy-to-use, powerful, open-source data querying application. Check out the [Github repository](http://github.com/dpaola2/QueryClips).

# Features

- Write queries & save results
- Easy sharing & exporting to CSV & JSON
- Database schema quick-reference
- Support for multiple database connections
- Support for both PostgreSQL and MySQL
- Simple & easy self-hosting (See "Deploying to Heroku" section below.)

# Roadmap

In the short term, we aim to provide:

- Live demo instance to explore QueryClips
- Preflight check: onboarding & configuration help
- Developer-friendly visualizations

# Starmap

In addition to our short term plans, we aim to eventually provide:

- Organize your queries
- SQL library
- Visually pleasing query experience
- Powerful point-and-click querying
- A hosted version of QueryClips for teams that don't wish to host their own instances
- Pivoting and Drilldown ability
- Comprehensive data exporting
- Chat bot integration
- Webhooks
- Reports by email
- Dashboards

# Usage

## Deploying to Heroku

Click this button: [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/dpaola2/QueryClips)<

This will deploy a free heroku application with a hobby Postgresql addon.

## Updating

If you used the Heroku deploy button to deploy QueryClips, you will need to take the following steps the first time you update:

1. Clone the repository: `git clone git@github.com:dpaola2/QueryClips.git`
2. CD into the repository: `cd QueryClips`
3. Log into your heroku dashboard and find the git URL for the heroku app that corresponds to your instance. Then, run `git remote add <heroku git url>`

Then, whenever you want to update, you simply:

1. `git pull origin master`
2. `git push heroku master`
3. `heroku run rake db:migrate`

# Dev Installation

## Requirements:

- Rails 4.1
- Ruby 2.2.4
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

Contributions are welcome! Please use pull requests.

A great way to get started is to:

1. Improve documentation
2. Pick an issue marked as [help wanted](https://github.com/dpaola2/QueryClips/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22) and comment on the issue with your intention to contribute to it.

While we appreciate contributors, we will be sticking to our roadmap. Please talk to us before you begin coding so that we can confirm that your intended bugfix / feature / enhancement has a high likelihood of being accepted.

# License

QueryClips is licensed under the Apache 2.0 licence. See [LICENSE](LICENSE) for details.

