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

# for send to pinger result
ping_result = ""

# for ping
addr = ["13.112.63.251","46.51.255.254","52.68.63.252","52.192.63.252","52.196.63.252","54.64.0.2","54.92.0.2","54.95.0.2"]

time = Time.now.localtime.strftime("%m月 %d日 %H:%M:%S")
# inger = Net::Ping::External.new(addr)
# get message
bot.message do |bm|

  p bm.user
  p bm.channel

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

    addr.each_with_index do |p,index|
      pinger = Net::Ping::External.new(addr[index])
      if pinger.ping?
        ping_result = "#{time}現在、#{index+1}番目のサーバーがしんでるよ!"
      else
        if index == addr.length
          ping_result = "#{time}現在、すべてのサーバーは動いてるよ!"
        end
      end
    end

    bm.send_message ping_result
  end

  # *----------  Regularly  ----------*/
  if bm.content === "watch"
    while true do
      addr.each_with_index do |p,index|
        pinger = Net::Ping::External.new(addr[index])
        if pinger.ping?
          ping_result = "#{time}現在、#{index+1}番目のサーバーがしんでるよ!"
        else
          if index == addr.length
            ping_result = "#{time}現在、すべてのサーバーは動いてるよ!"
          end
        end
      end
      bm.send_message ping_result
      sleep(7600)
    end
  end

end

bot.run