class EnableSSLJob < ApplicationJob
  attr_reader :app

  def perform(app)
    @app = app
    cert = create_tmp_file(app.ssl_cert)
    key = create_tmp_file(app.ssl_key)
    copy_file(from: cert.path, to: server_cert_path)
    copy_file(from: key.path, to: server_key_path)
    install_certificate
    clean_certificate_files
  end

  private

  def create_tmp_file(data)
    tmp_file = Tempfile.new
    tmp_file.write(data)
    tmp_file.close
    tmp_file
  end

  def server_cert_path
    "/root/#{app.clean_name}.server.crt"
  end

  def server_key_path
    "/root/#{app.clean_name}.server.key"
  end

  def server_tar_path
    "/root/#{app.clean_name}.cert.tar"
  end

  def copy_file(from:, to:)
    SshExecution.new(app.server).scp(from: from, to: to, direction: :upload)
  end

  def install_certificate
    SshExecution.new(app.server).
      execute(command: "tar -cvf #{server_tar_path} #{server_cert_path} #{server_key_path}")
    SshExecution.new(app.server).
      execute(command: "dokku certs:add #{app.clean_name} < #{server_tar_path}")
  end

  def clean_certificate_files
    SshExecution.new(app.server).
      execute(command: "rm #{server_key_path} && rm #{server_cert_path} && "\
              "rm #{server_tar_path}")
  end
end
