namespace :intercity do
  desc "Seed plugins"
  task seed_plugins: :environment do
    plugins = [
      { name: "Redis", active: true,
        commands: { install: "sudo dokku plugin:install https://github.com/dokku/dokku-redis.git redis",
                    create: "dokku redis:create %app_name%_redis",
                    destroy: "dokku redis:destroy %app_name%_redis force",
                    unlink: "dokku redis:unlink %app_name%_redis %app_name%",
                    link: "dokku redis:link %app_name%_redis %app_name%",
                    backup: "dokku redis:export %app_name%_redis" }},
      { name: "Memcached", active: true,
        commands: { install: "sudo dokku plugin:install https://github.com/dokku/dokku-memcached.git memcached",
                    create: "dokku memcached:create %app_name%_memcached",
                    destroy: "dokku memcached:destroy %app_name%_memcached force",
                    unlink: "dokku memcached:unlink %app_name%_memcached %app_name%",
                    link: "dokku memcached:link %app_name%_memcached %app_name%",
                    backup: false }},
      { name: "Postgres", active: true,
        commands: { install: "sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres",
                    create: "dokku postgres:create %app_name%_postgres",
                    destroy: "dokku postgres:destroy %app_name%_postgres force",
                    unlink: "dokku postgres:unlink %app_name%_postgres %app_name%",
                    link: "dokku postgres:link %app_name%_postgres %app_name%",
                    backup: "dokku postgres:export %app_name%_postgres" }},
      { name: "Mysql", active: true,
        commands: { install: "dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql",
                    create: "dokku mysql:create %app_name%_mysql",
                    destroy: "dokku mysql:destroy %app_name%_mysql force",
                    unlink: "dokku mysql:unlink %app_name%_mysql %app_name%",
                    link: "dokku mysql:link %app_name%_mysql %app_name%",
                    backup: "dokku mysql:export %app_name%_mysql" }},
      { name: "Elasticsearch", active: true,
        commands: { install: "dokku plugin:install https://github.com/dokku/dokku-elasticsearch.git elasticsearch",
                    create: "dokku elasticsearch:create %app_name%_elasticsearch",
                    destroy: "dokku elasticsearch:destroy %app_name%_elasticsearch force",
                    unlink: "dokku elasticsearch:unlink %app_name%_elasticsearch %app_name%",
                    link: "dokku elasticsearch:link %app_name%_elasticsearch %app_name%",
                    backup: false }}
    ]

    plugins.each do |plugin_data|
      plugin = Service.find_or_initialize_by(name: plugin_data[:name])
      plugin.update(plugin_data)
    end
  end
end
