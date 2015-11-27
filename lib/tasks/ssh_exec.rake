namespace :ssh_exec do
  desc "Test interaction with SSH"
  task test: :environment do
    s = Server.first
    SshExecution.new(s).execute_with_block do |ssh|
      ssh.open_channel do |ch|
        ch.exec "dokku apps:destroy test3" do |ch, success|
          abort "could not destroy app" unless success

          ch.on_data do |ch, data|
            print data
            if data =~ /To proceed, type "test3"/
              ch.send_data("test3\n")
            end
          end
        end
      end
    end
  end
end
