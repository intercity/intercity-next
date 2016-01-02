every :day, at: '1:00am' do
  command "/usr/local/bin/backup perform -t intercity -c /var/www/intercity/config/backup/config.rb -d /shared/backups/"
end
