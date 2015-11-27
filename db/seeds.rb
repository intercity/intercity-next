Server.create!(name: "Vagrant", ip: "10.0.0.2")

Service.create!(name: "Redis", git_url: "https://github.com/dokku/dokku-redis.git", active: true,
                commands: { install: "sudo dokku plugin:install https://github.com/dokku/dokku-redis.git redis" })
Service.create!(name: "Postgres", git_url: "https://github.com/dokku/dokku-postgres.git", active: true,
                commands: { install: "sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres" })
