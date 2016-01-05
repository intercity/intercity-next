namespace :ssh_exec do
  desc "Test interaction with SSH"
  task test: :environment do
    s = Server.first
    output = ""
    SshExecution.new(s).execute_with_block do |ssh|
      ssh.open_channel do |ch|
        ch.exec "dokku postgres:export formbox_postgres" do |ch, success|
          abort "could not destroy app" unless success

          ch.on_data do |ch, data|
            output << data
          end
        end
      end
    end
    puts output
  end
end
