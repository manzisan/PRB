require 'discordrb'
require 'date'

bot = Discordrb::Bot.new token: 'MzcwMDMyMzkyMTU4NTc2NjQw.DMjHhg.qmoKjIrGvinDEXBg8AJilMvyLmM', client_id: 370032392158576640

 # for echo
 # event.respond METHOD

bot.message do |bm|
  p "------------------------------------"
  p ("ユーザー名 : #{bm.user.name}")
  p ("ユーザーID : #{bm.user.id}")
  p ("メッセージ : #{bm.content}")
  p ("タイムスタンプ : #{bm.timestamp.localtime}")
  p "------------------------------------"

  # 特定のアホにコメントを送り返す用

  if bm.user.id === 351323974703251456 #かつや
    bm.respond "かつやは死んでね"
  elsif bm.user.id === 325812579392028674 #ぶっち
    bm.respond "ぶっちんこｗｗｗ"
  elsif bm.user.id === 269453299743195137 #おかっち
    bm.respond "叙々苑!?"
  elsif bm.user.id === 308880612914233344 #しおん
    bm.respond "小森　純です"
  elsif bm.user.id === 355359958415704065 #なるさま
    bm.respond "またスケベしてきたのか"
  end

end

bot.run

# https://discordapp.com/oauth2/authorize?&client_id=370032392158576640&scope=bot&permissions=0