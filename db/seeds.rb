User.create!(email: "user@example.com", password: "12345678")

Rake::Task["intercity:seed_plugins"].invoke
