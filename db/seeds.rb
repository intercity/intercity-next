Server.create!(name: "Vagrant", ip: "10.0.0.2")

Service.create!(name: "Redis", active: true,
                commands: { install: "sudo dokku plugin:install https://github.com/dokku/dokku-redis.git redis" })

Service.create!(name: "Postgres", active: true,
                commands: { install: "sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres" })

Service.create!(name: "Mysql", active: true,
                commands: { install: "dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql" })

Service.create!(name: "Elasticsearch", active: true,
                commands: { install: "dokku plugin:install https://github.com/dokku/dokku-elasticsearch.git elasticsearch" })
