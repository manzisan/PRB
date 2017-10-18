require 'discordrb'
 
bot = Discordrb::Bot.new token: 'MzcwMDMyMzkyMTU4NTc2NjQw.DMikxQ.gIgLIDHf9r3qH6UTxE7mfaMWelk', client_id: 370032392158576640
 
bot.message do |event|
    event.respond 'Hello, world!'
end

bot.run