require 'discordrb'
require 'date'
require 'twitter'
require 'net/ping'
# require 'FileUtils'


# Discord BOT Token
bot = Discordrb::Bot.new token: 'MzcwMDMyMzkyMTU4NTc2NjQw.DMjHhg.qmoKjIrGvinDEXBg8AJilMvyLmM', client_id: 370032392158576640

 # for echo
 # event.respond METHOD

bot.message do |bm|
  # *----------  ログとして出力  ----------*/
  # @file = "/chat-log.txt"
  # FileUtils.chmod(777, @file)
  # File.open(@file, "w") do |f|
  #   f.puts "------------------------------------"
  #   f.puts ("ユーザー名 : #{bm.user.name}")
  #   f.puts ("ユーザーID : #{bm.user.id}")
  #   f.puts ("メッセージ : #{bm.content}")
  #   f.puts ("タイムスタンプ : #{bm.timestamp.localtime}")
  #   f.puts "------------------------------------"
  # end

  # メッセージを送ったユーザーのデータを取得
  p "------------------------------------"
  p ("ユーザー名 : #{bm.user.name}")
  p ("ユーザーID : #{bm.user.id}")
  p ("メッセージ : #{bm.content}")
  p ("タイムスタンプ : #{bm.timestamp.localtime}")
  p "------------------------------------"


  # 特定のユーザーにコメントを送り返す
  if bm.user.id === 351323974703251456 #かつや
    bm.respond "かつくんって呼ばれると勃ちます"
  elsif bm.user.id === 325812579392028674 #ぶっち
    bm.respond "ぶっち童貞捨てた？"
  elsif bm.user.id === 269453299743195137 #おかっち
    bm.respond "叙々苑!?"
  elsif bm.user.id === 308880612914233344 #しおん
    bm.respond "小森　純です"
  elsif bm.user.id === 355359958415704065 #なるさま
    bm.respond "またスケベしてきたのか"
  end
end

def PUBGstatus
  bot.message do |bm|

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = 'l1DSd1hSKgIroTZRTEVqdw0xY'
      config.consumer_secret = 'AfMZKoxS9BSxI1doYSQuTv0meWYI7Tb4CRKx2OA432O94GAOti'
      config.access_token    = '1217512579-nPNzvgTqigbVMeHaVktRTWg5uOE8ABAE6CB7kLM'
      config.access_token_secret = 's8Q07LeOjGbN2FppWvfwq8zFkFTyJFMf6pVtq8mg6HLPE'
    end

    # *----------  PUBGのtimeline取得  ----------*/
    @client.user_timeline("PUBG_JAPAN",count: 1).each do |timeline|
      bm.send_message @client.status(timeline.id).text
    end

    # *----------  確認したいpingの宛先を指定  ----------*/
    # addr = Array("13.112.63.251","46.51.255.254") #PUBG Tokyo server's IP
    addr = "13.112.63.251"
    pinger = Net::Ping::External.new(addr)

    # *----------  Pingテスト  ----------*/
    if pinger.ping?
      bm.send_message ("#{Time.now}時、PUBGサーバーは正常稼動中です。")
    else
      bm.send_message ("#{Time.now}時、サーバーがダウンしています")
    end
  end
end

bot.run
PUBGstatus
# https://discordapp.com/oauth2/authorize?&client_id=370032392158576640&scope=bot&permissions=0