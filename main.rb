require 'discordrb'

bot = Discordrb::Bot.new token: 'MzcwMDMyMzkyMTU4NTc2NjQw.DMjHhg.qmoKjIrGvinDEXBg8AJilMvyLmM', client_id: 370032392158576640

 # for echo
 # event.respond METHOD

bot.message do |bm|
  p "------------------------------------"
  p ("ユーザー名 : #{bm.user.name}")
  p ("ユーザーID : #{bm.user.id}")
  p ("メッセージ : #{bm.content}")
  p "------------------------------------"
  if bm.user.id === 351323974703251456
    bm.respond "かつやは死んでね"
  end
end

bot.run

# https://discordapp.com/oauth2/authorize?&client_id=370032392158576640&scope=bot&permissions=0