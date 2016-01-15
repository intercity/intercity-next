class ServersController < ApplicationController
  def index
    @servers = Server.all.order(created_at: :desc)
  end

  def new
    @server = Server.new
  end

  def show
    @server = Server.find(params[:id])
    case @server.status
    when "fresh", "connected"
      @ssh_key = SSHKey.new(@server.rsa_key_private, comment: "Intercity").ssh_public_key
      render "servers/show/add_ssh"
    when "installing"
      render "servers/show/installing"
    when "up"
      redirect_to server_apps_path(@server)
    when "down"
      render "servers/show/down"
    end
  end

  def create
    @server = Server.new(server_params)
    if @server.save
      redirect_to server_path(@server)
    else
      render :new
    end
  end

  def test_ssh
    @server = Server.find(params[:id])
    begin
      output = SshExecution.new(@server).execute(command: "sudo ls")
      if output =~ /sudo/
        @error = "We can connect, but don't have sudo access"
        @connected = false
      else
        @connected = true
        @server.update(status: "connected")
      end
    rescue Net::SSH::ConnectionTimeout, Net::SSH::AuthenticationFailed, Errno::EHOSTUNREACH,
           Errno::ECONNREFUSED, Errno::EHOSTDOWN
      @connected = false
    end
  end

  def check_installation
    @server = Server.find(params[:id])
  end

  def start_installation
    @server = Server.find(params[:id])
    if @server.connected?
      InstallServerJob.perform_later(@server)
      @server.update(status: "installing")
    end
    redirect_to server_path(@server)
  end

  def start_update
    @server = Server.find(params[:id])
    if VersionParser.parse(@server.dokku_version) < VersionParser.parse("v0.4.11")
      redirect_to manual_update_server_path(@server)
    else
      unless @server.updating?
        UpdateServerJob.perform_later(@server)
        @server.update(updating: true)
      end

      redirect_to updating_server_path(@server)
    end
  end

  def updating
    @server = Server.find(params[:id])
  end

  def manual_update
    @server = Server.find(params[:id])
  end

  def destroy
    @server = Server.find(params[:id])
    @server.destroy
    redirect_to root_path
  end

  private

  def server_params
    params.require(:server).permit(:name, :ip)
  end
end
