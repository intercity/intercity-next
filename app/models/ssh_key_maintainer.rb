class SshKeyMaintainer
  def initialize(server)
    @server = server
  end

  def create_key_for_connection
    File.open(key_path, "w+", 0o600) do |f|
      f.write(server.rsa_key_private)
    end

    key_filename
  end

  def key
    create_key_for_connection if key_filename.nil?
    key_path
  end

  def delete_ssh_key_for_connection
    File.delete(key) if key_filename
  end

  private

  attr_reader :server

  def key_path
    FileUtils.mkdir_p("keys") unless File.directory?("keys")
    Rails.root.join("keys", key_filename)
  end

  def key_filename
    @key_filename ||= "#{server.id}_#{apply_stamp}_key_#{SecureRandom.hex(5)}"
  end

  def apply_stamp
    @apply_stamp ||= Time.now.to_i
  end
end
