Thread.abort_on_exception = true
require 'timers'
require 'docker'
require 'discordrb'
require './listeners/minecraft'

# I'm listening
module Listen
  def self.start
    @timers = Timers::Group.new
    @bot = Discordrb::Commands::CommandBot.new(token: ENV['TOKEN'], prefix: ENV['PREFIX'])
    @bot.ready do
      puts 'hell ya'
      game_loop
    end
    @bot.run
  end

  def self.game_loop
    puts 'away we go'
    @timers.now_and_every(30) do
      MinecraftListener.listen(@bot)
    end
    Thread.new { loop { @timers.wait } }
  end
end
