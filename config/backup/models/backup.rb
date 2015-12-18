# encoding: utf-8
Backup::Model.new(:intercity, 'Intercity full backup') do
  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = "intercity"
    db.host               = "localhost"
    db.port               = 5432
    db.socket             = "/var/run/postgresql"
    db.additional_options = ["-xc", "-E=utf8"]
  end

  store_with Local do |local|
    local.path = '/shared/backups/'
    # Use a number or a Time object to specify how many backups to keep.
    local.keep = 10
  end

  archive :intercity_data do |archive|
    archive.add '/var/www/intercity'
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip
end
