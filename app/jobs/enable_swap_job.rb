class EnableSwapJob < ApplicationJob
  attr_reader :server

  def perform(server)
    @server = server

    upload_swap_script
    enable_swap
    remove_swap_script
  end

  private

  def upload_swap_script
    SshExecution.new(server).scp(from: Rails.root.join("scripts", "enable_swap.sh"),
                                 to: swap_file,
                                 direction: :upload)
  end

  def enable_swap
    SshExecution.new(server).execute(command: "sudo sh #{swap_file}")
  end

  def remove_swap_script
    SshExecution.new(server).execute(command: "rm #{swap_file}")
  end

  def swap_file
    "/#{server.username}/enable_swap.sh"
  end
end
