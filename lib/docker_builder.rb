class DockerBuilder
  def initialize
    @env_vars = ""
  end

  def set_app(app)
    add_env_var("KEY", app.server.rsa_key_private).
    add_env_var("HOST", "#{app.server.ip},")
    self
  end

  def add_env_var(key, value)
    @env_vars << "-e \"#{key}=#{value}\" "
    self
  end

  def add_encoded_vars(key, values)
    encoded_vars = Base64.encode64(values.to_json)
    @env_vars << "-e \"#{key}=#{encoded_vars}\" "
    self
  end

  def run
    cmd = "docker run #{@env_vars} -t intercity/runner"
    system(cmd)
  end
end
