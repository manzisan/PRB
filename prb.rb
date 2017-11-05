require 'date'
require 'net/ping'

# for Token's
require 'discordrb'
require 'twitter'
require './token'

# create Discord BOT
bot = Discordrb::Bot.new token: @d_token, client_id: @id

# Keep current tweet
current = ""

# for ping
addr = "13.112.63.251"
pinger = Net::Ping::External.new(addr)
time = Time.now.localtime.strftime("%m月 %d日 %H:%M:%S")

# get message
bot.message do |bm|

    # *----------  Puts log  ----------*/
    File.chmod(0777, "chat-log.txt")
    File.open("chat-log.txt", "a") do |f|
      f.puts "------------------------------------"
      f.puts ("ユーザー名 : #{bm.user.name}")
      f.puts ("メッセージ : #{bm.content}")
      f.puts ("時刻 : #{bm.timestamp.localtime.strftime("%m月 %d日 %H:%M:%S")}")
      f.puts "------------------------------------"
    end

    # *----------  Puts PUBG status  ----------*/
    if bm.content === "pubg"
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key    = @key
        config.consumer_secret = @secret_key
        config.access_token    = @t_token
        config.access_token_secret = @secret_token
      end

      # *----------  get PUBG timeline  ----------*/
      @client.user_timeline("PUBG_JAPAN",count: 1).each do |timeline|
        if current != @client.status(timeline.id).text
          bm.send_message @client.status(timeline.id).text
        else
          bm.send_message "新着ツイートはありません。"
        end
        current = @client.status(timeline.id).text
      end

      # *----------  Ping  ----------*/
      if pinger.ping?
        bm.send_message ("#{time}現在、PUBGサーバーは正常稼動中です。")
      else
        bm.send_message ("#{time}現在、サーバーがダウンしています")
      end
    end

    # *----------  Regularly  ----------*/
    if bm.content === "watch"
      while true do
        flag = 0
        # *----------  Ping  ----------*/
        if pinger.ping?
          bm.send_message ("#{time}現在、PUBGサーバーは正常稼動中です。")
        else
          bm.send_message ("#{time}現在、サーバーがダウンしています")
        end
        sleep(7600)
      end
    end

    # Reply for specific user
    if bm.user.id === 351323974703251456 #かつや
      # bm.send_message ""
    elsif bm.user.id === 325812579392028674 #ぶっち
      # bm.send_message "うるせぐすな"
    elsif bm.user.id === 269453299743195137 #おかっち
      # bm.send_message "叙々苑!?"
    elsif bm.user.id === 308880612914233344 #しおん
      # bm.send_message ""
    elsif bm.user.id === 355359958415704065 #なるさま
      bm.send_message "またスケベしてきたのか"
    end
end

bot.run