require 'securerandom'

token = SecureRandom.hex(64)

begin
  current_token = Redis.current.get("SECRET_KEY_BASE")
  if current_token.blank?
    Redis.current.set("SECRET_KEY_BASE", token)
  else
    token = current_token
  end
rescue => e
  puts e.inspect
end

Rails.application.config.secret_token = token
Rails.application.config.secret_key_base = token
