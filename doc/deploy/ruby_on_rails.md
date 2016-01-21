# How to deploy a Ruby on Rails app

## Set up correct ENV Vars

TODO

## Set up the proper database

TODO

## Configure your app server

TODO

## Run migration on deployments

Intercity does run your Assets precompile tasks on every deploy. We can hook
into this Rake task by adding the following file:

```ruby
# lib/tasks/run_migrations.rake
Rake::Task['assets:clean'].enhance do
  Rake::Task['db:migrate'].invoke
end
```
