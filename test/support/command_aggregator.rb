class CommandAggregator
  attr_reader :commands
  delegate :count, to: :@commands

  def initialize
    @commands = []
  end

  def add(command)
    @commands << command
  end

  def count
    @commands.count
  end
end
