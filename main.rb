require 'discordrb'
require 'date'
require 'twitter'
require 'net/ping'

# for Token's
require './token'

# Discord BOT
bot = Discordrb::Bot.new token: @d_token, client_id: @id


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

  if bm.content === "pubg"
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = @key
      config.consumer_secret = @secret_key
      config.access_token    = @t_token
      config.access_token_secret = @secret_token
    end

    # *----------  PUBGのtimeline取得  ----------*/
    @client.user_timeline("PUBG_JAPAN",count: 1).each do |timeline|
      bm.send_message @client.status(timeline.id).text
    end

    # *----------  確認したいpingの宛先を指定  ----------*/
    # addr = Array("13.112.63.251","46.51.255.254") #PUBG Tokyo server's IP
    addr = "13.112.63.251"
    pinger = Net::Ping::External.new(addr)

    time = Time.now.localtime.strftime("%m月 %d日 %H:%M:%S")

    # *----------  Pingテスト  ----------*/
    if pinger.ping?
      # bm.send_message ("#{time}現在、PUBGサーバーは正常稼動中です。")
      bm.send_message ("#{time}現在、PUBGサーバーは正常稼動中です。")
    else
      bm.send_message ("#{time}現在、サーバーがダウンしています")
    end
  end 
  
  # メッセージを送ったユーザーのデータを取得
  p "------------------------------------"
  p ("ユーザー名 : #{bm.user.name}")
  p ("ユーザーID : #{bm.user.id}")
  p ("メッセージ : #{bm.content}")
  p ("タイムスタンプ : #{bm.timestamp.localtime.strftime("%m月 %d日 %H:%M:%S")}")
  p "------------------------------------"

  if bm.content === "かつや"
    bm.send_message "PUBG下手くそな人だ！"
  end

  # 特定のユーザーにコメントを送り返す
  if bm.user.id === 351323974703251456 #かつや
    # bm.respond "かつくんって呼ばれると勃ちます"
  elsif bm.user.id === 325812579392028674 #ぶっち
    # bm.respond "ぶっち童貞捨てた？"
  elsif bm.user.id === 269453299743195137 #おかっち
    # bm.respond "叙々苑!?"
  elsif bm.user.id === 308880612914233344 #しおん
    # bm.respond "小森　純です"
  elsif bm.user.id === 355359958415704065 #なるさま
    # bm.respond "またスケベしてきたのか"
  end
end

bot.run