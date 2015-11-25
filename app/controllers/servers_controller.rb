class ServersController < ApplicationController
  def index
    @servers = Server.all.order(created_at: :asc)
  end

  def new
    @server = Server.new
  end

  def show
    @server = Server.find(params[:id])
    case @server.status
    when "setup"
      @ssh_key = SSHKey.new(@server.rsa_key_private, comment: "Intercity").ssh_public_key
      render "servers/show/setup"
    when "up"
      render "servers/show/up"
    when "down"
      render "servers/show/down"
    end
  end

  def create
    @server = Server.new(server_params)
    if @server.save
      flash[:success] = "Your new server is added to your dashboard"
      redirect_to root_path
    else
      render :new
    end
  end

  def ssh_key
    @server = Server.find(params[:id])
    @ssh_key = SSHKey.new(@server.rsa_key_private, comment: "Intercity Dokku")
  end

  def test
    @server = Server.find(params[:id])
    begin
      SshExecution.new(@server).execute(command: "sudo ls")
      @server.update(status: "up")
      @connected = true
    rescue Net::SSH::ConnectionTimeout, Net::SSH::AuthenticationFailed, Errno::EHOSTUNREACH,
           Errno::ECONNREFUSED, Errno::EHOSTDOWN
      @connected = false
    end
  end

  private

  def server_params
    params.require(:server).permit(:name, :ip)
  end
end
