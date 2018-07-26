require 'securerandom'

$redis ||= Redis.new(url: ENV["REDIS_URL"])

token = $redis.get("SECRET_KEY_BASE")
if token.nil?
  token = SecureRandom.hex(64)
  $redis.set("SECRET_KEY_BASE", token)
end

Rails.application.config.secret_token = token
Rails.application.config.secret_key_base = token
