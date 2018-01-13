# Intercity Next

[![Build Status](https://semaphoreci.com/api/v1/projects/454e65b7-3f98-4c08-8ddb-7fea8ffa5227/628590/shields_badge.svg)](https://semaphoreci.com/jvanbaarsen/intercity-next)
[![Code Climate](https://codeclimate.com/github/intercity/intercity-next/badges/gpa.svg)](https://codeclimate.com/github/intercity/intercity-next)

## Requirements

* Any Ubuntu 14.04 or 16.04 LTS server.
* 1024 MB ram. 512 is possible, but requires swap of at least 1gb.

## Installation on production server

For installation instructions, please see our [install manual][install]

## Set up your Dev environment

1. Make sure you have PostgreSQL and Redis installed
2. Clone this repo
3. Run `bin/setup`
4. Start the app with `foreman start`

## Set up your Dev environment using Docker

You can also set up your local development environment without having to install
any outside dependencies. For this, use the Docker Compose configuration that's
available in this repository. This configuration automatically mounts your
local code inside a container, so that you can make changes and commit your
code as if you were running a local development server without Docker.

First, install Docker for your workstation: https://www.docker.com/community-edition

Then, use `docker-compose` commands to set up a local environment using Docker
and run the development server:

```
$ docker-compose run web rails db:create
$ docker-compose run web rails db:schema:load
```

Optionally, run the seeds to already have an initial user and if you don't
need to test the onboarding:

```
$ docker-compose run web rake db:seed
```

Then, start the local development server:

```
$ docker-compose run web -p 3000:3000 rails s
```

You can start Sidekiq for background jobs via:

```
$ docker-compose run sidekiq -q default -q mailers -q health_checks
```

Or alternatively, to start everything in one go:

```
$ docker-compose up
```

### Running tests

You can run tests via:

```
$ docker-compose run web rails test
```

### Running DB migrations

You can run database migrations via:

```
docker-compose run web rails db:migrate
```

## Support

You can use [Github Issues][gh-issues], or join us on [freenode in #intercity][irc]

## Contributing

We encourage you to contribute to Intercity! Join us!

Everyone interacting in Intercity and its sub-projects' codebases, issue trackers,
chat rooms, and mailing lists is expected to follow the [Intercity code of conduct][coc].

[coc]: https://github.com/intercity/intercity-next/blob/master/CODE_OF_CONDUCT.md
[gh-issues]: https://github.com/intercity/intercity-next/issues
[irc]: https://webchat.freenode.net/?channels=#intercity
[install]: doc/installation.md
