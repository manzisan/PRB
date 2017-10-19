# for gem install
require 'discordrb'
require 'twitter'

require 'date'
require 'net/ping'

# for Token's
require './token'

# Discord BOT
bot = Discordrb::Bot.new token: @d_token, client_id: @id

# get message
bot.message do |bm|

  # get API Data
  # bm.user.id => ID
  # bm.content => Message
  # bm.user.name => User Name
  # bm.timestamp => Time Stamp
  # bm.channel =>　Using Channel

  # *----------  Puts log  ----------*/
  # @file = "/chat-log.txt"
  # FileUtils.chmod(777, @file)
  # File.open(@file, "w") do |f|
  #   f.puts "------------------------------------"
  #   f.puts ("User Name : #{bm.user.name}")
  #   f.puts ("User Id : #{bm.user.id}")
  #   f.puts ("Message : #{bm.content}")
  #   f.puts ("Time Stamp : #{bm.timestamp.localtime.strftime("%m月 %d日 %H:%M:%S")}")
  #   f.puts "------------------------------------"
  # end

  # puts pubg status
  if bm.content === "pubg"
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = @key
      config.consumer_secret = @secret_key
      config.access_token    = @t_token
      config.access_token_secret = @secret_token
    end

    # *----------  get PUBG timeline  ----------*/
    @client.user_timeline("PUBG_JAPAN",count: 1).each do |timeline|
      bm.send_message @client.status(timeline.id).text
    end

    # *----------  ping list  ----------*/
    # addr = Array("13.112.63.251","46.51.255.254") #PUBG Tokyo server's IP
    addr = "13.112.63.251"
    pinger = Net::Ping::External.new(addr)

    time = Time.now.localtime.strftime("%m月 %d日 %H:%M:%S")

    # *----------  Ping  ----------*/
    if pinger.ping?
      bm.send_message ("#{time}現在、PUBGサーバーは正常稼動中です。")
    else
      bm.send_message ("#{time}現在、サーバーがダウンしています")
    end
  end 
  
  # get user status
  p "------------------------------------"
  p ("User Name : #{bm.user.name}")
  p ("User Id : #{bm.user.id}")
  p ("Message : #{bm.content}")
  p ("Time Stamp : #{bm.timestamp.localtime.strftime("%m月 %d日 %H:%M:%S")}")
  p "------------------------------------"

  # Reply for specific user
  if bm.user.id === 351323974703251456 #かつや
    # bm.respond "かつくんって呼ばれると勃ちます"
  elsif bm.user.id === 325812579392028674 #ぶっち
    # bm.respond "ぶっち童貞捨てた？"
  elsif bm.user.id === 269453299743195137 #おかっち
    bm.respond "叙々苑!?"
  elsif bm.user.id === 308880612914233344 #しおん
    # bm.respond "小森　純です"
  elsif bm.user.id === 355359958415704065 #なるさま
    bm.respond "またスケベしてきたのか"
  end
end

bot.run