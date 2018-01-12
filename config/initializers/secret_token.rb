require 'securerandom'

token = SecureRandom.hex(64)

begin
  token = Redis.current.get("SECRET_KEY_BASE")
  if token.nil?
    Redis.current.set("SECRET_KEY_BASE", token)
  end
rescue
  Rails.application.config.secret_token = token
  Rails.application.config.secret_key_base = token
end
