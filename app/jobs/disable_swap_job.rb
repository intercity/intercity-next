class DisableSwapJob < ApplicationJob
  attr_reader :server

  def perform(server)
    @server = server

    upload_swap_script
    disable_swap
    remove_swap_script
  end

  private

  def upload_swap_script
    SshExecution.new(server).scp(from: Rails.root.join("scripts", "disable_swap.sh"),
                                 to: swap_file,
                                 direction: :upload)
  end

  def disable_swap
    SshExecution.new(server).execute(command: "sh #{swap_file}")
  end

  def remove_swap_script
    SshExecution.new(server).execute(command: "rm #{swap_file}")
  end

  def swap_file
    "/#{server.username}/disable_swap.sh"
  end
end
