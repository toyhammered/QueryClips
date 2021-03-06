# QueryClips

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/dpaola2/QueryClips)

QueryClips is an easy-to-use, powerful, open-source data querying application. Check out the [Github repository](http://github.com/dpaola2/QueryClips).

# Features

- Write queries & save results
- Easy sharing & exporting to CSV & JSON
- Email yourself your Query Clips
- Database schema quick-reference
- Support for multiple databases
- Support for PostgreSQL and MySQL
- Quick & easy self-hosting (See "Deploying to Heroku" section below.)

# Roadmap

In the short term, we aim to provide:

- Reports by email
- Developer-friendly visualizations
- Improved user management (invite, reset password)

# Starmap

In addition to our short term plans, we aim to eventually provide:

- A hosted version of QueryClips for teams that don't wish to host their own instances
- Improved organization for your clips
- SQL library
- Powerful point-and-click querying
- Support for MariaDB, Microsoft SQL Server, Oracle, and more
- Pivoting and Drilldown ability
- Comprehensive data exporting
- Chat bot integration
- Webhooks
- Dashboards

# Usage

## Deploying to Heroku

Click this button: [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/dpaola2/QueryClips)

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

## Configuration

All configuration is stored in environment variables. The following variables are used:

- `HOST`: Required. For example, `queryclips.com` or `localhost:3000`.
- `MAIL_FROM_ADDRESS`: Optional. The default from address for email. Defaults to `noreply@queryclips.com`.
- `ALLOW_SIGNUP`: Optional. Set this to `false` to disable signups.

### Mail

The following environment variables are required in order to send mail:

- `SMTP_HOST`
- `SMTP_PORT`
- `SENDGRID_USERNAME`
- `SENDGRID_PASSWORD`
- `SMTP_DOMAIN`

We recommend using the [SendGrind](https://devcenter.heroku.com/articles/sendgrid) add-on if you're hosting QueryClip yourself on Heroku.

### Daily Digest

Using the Heroku Scheduler addon (`heroku addons:open scheduler`), schedule the rake task to run every day at 8am:

![](https://www.dropbox.com/s/rtp3y5e2xsqq6av/Screenshot%202016-08-20%2012.42.25.png?dl=1)

# Dev Installation

## Requirements:

- Rails 4.1
- Ruby 2.2.4+
- Postgres 9.4.4+

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

1. Claim a task from the [Help Wanted](https://github.com/dpaola2/QueryClips/projects/1) project
2. dig around in the code a bit and figure out how you’d go about solving the problem. Then comment on the github issue with your proposed plan of attack
3. Implement it and pull request

While we appreciate contributors, we will be sticking to our roadmap. Please talk to us before you begin coding so that we can confirm that your intended bugfix / feature / enhancement has a high likelihood of being accepted.

# License

QueryClips is licensed under the Apache 2.0 licence. See [LICENSE](LICENSE) for details.

