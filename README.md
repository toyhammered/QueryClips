# Duplo

Duplo is a simple, powerful, open-source data querying service.

## Near-term Roadmap

In the short term, we aim to provide:

- simple querying, saved queries, and export to CSV functionality
- easy deployment instructions for small teams who wish to host their own instances
- user accounts

## Long-term Roadmap

In addition to our short term plans to allow simple querying and sharing, we aim to ultimately provide:

- A visually pleasing query experience
- A powerful point-and-click query editor
- Developer-friendly visualizations
- Comprehensive data exporting
- Mechanism for organizing queries
- A chat bot for quick access to your queries
- A hosted version of Duplo for teams that don't wish to host their own instances
- Dashboards
- Reports by email


## Installation

1. Clone the repo: `git clone git@github.com:dpaola2/Duplo.git`
2. Create your database: `createdb duplo_development`
3. Bundle install: `bundle install`
4. Run migrations: `bin/rake db:migrate`
5. Run the server: `foreman start`
6. Hit `localhost:3000` in your browser.


## Feature Requests

Please open an github issue to request a feature.

## Contributing

Contributions are welcome! Use pull requests.

## Screenshots

Creating new database connections:

![](https://www.dropbox.com/s/gwlwjddszvqh1gj/Screenshot%202016-04-02%2016.02.18.png?dl=1)

Querying:

![](https://www.dropbox.com/s/3186lctawgq0u92/Screenshot%202016-04-02%2015.57.33.png?dl=1)

![](https://www.dropbox.com/s/18w39nonq5hkh19/Screenshot%202016-04-02%2016.03.21.png?dl=1)

Saving Queries:

![](https://www.dropbox.com/s/sethdo8j5to7r05/Screenshot%202016-04-02%2016.03.30.png?dl=1)
