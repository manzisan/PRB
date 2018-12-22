require 'date'
require 'net/ping'
require 'faraday'
require 'net/http'
require 'uri'
require 'json'

# for Token's
require 'discordrb'
require 'twitter'
require './token'

# create Discord BOT
bot = Discordrb::Bot.new token: @discord_token

# Keep current tweet
current = ""

# for send to pinger result
ping_result = ""

# link discord ID to steam ID
ids = {
  # example
  # discord ID => steam ID
  250431830858268672 => 76561198078555010, #manzisan
  277342850939617282 => 76561198041478970, #jhon
  386408373832253440 => 76561198134941256, #shimopro
  351323974703251456 => 76561198172056539, #shakir
}
# for ping
addr = ["13.112.63.251"]

time = Time.now.localtime.strftime("%m月 %d日 %H:%M:%S")
# inger = Net::Ping::External.new(addr)
# get message
bot.message do |bm|

  # *----------  Puts PUBG status  ----------*/
  if bm.content === "pubg"
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = @key
      config.consumer_secret = @secret_key
      config.access_token    = @t_token
      config.access_token_secret = @secret_token
    end

    # *----------  get PUBG timeline  ----------*/
    @client.user_timeline("PUBG_JAPAN", count: 1).each do |timeline|
      if current != @client.status(timeline.id).text
        bm.send_message @client.status(timeline.id).text
      else
        bm.send_message "No have new tweet"
      end
      current = @client.status(timeline.id).text
    end

    addr.each_with_index do |p,index|
      pinger = Net::Ping::External.new(addr[index])
      if pinger.ping?
        ping_result = "Okay"
      else
        if index == addr.length
          ping_result = "unavailable"
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
          ping_result = "Okay"
        else
          if index == addr.length
            ping_result = "unavailable"
          end
        end
      end
      bm.send_message ping_result
      sleep(7600)
    end
  end

  if bm.content === '<@250431830858268672>'
    bm.send_message "<@#{bm.user.id}>"
  end

  if bm.content === '<@526007022588788746>'
    
    if !ids[bm.user.id]
      return bm.send_message "not registed you ID"
    end
    response = Faraday.get "http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?appid=730&key=#{@steam_api_key}&steamid=#{ids[bm.user.id]}"
    res = JSON.parse(response.body)
    stats = res["playerstats"]["stats"]
    ratio = ""
    headshot = ""
    stats.each do |stat|
      if stat["name"] == "total_kills_headshot"
        ratio = stats[0]["value"]/stats[1]["value"].to_f
        headshot = stats[0]["value"]/stat["value"].to_f*10
      end
    end
    bm.send_message "<@#{bm.user.id}>"
    bm.send_message "CSGO stats"
    bm.send_message "Ratio: #{ratio.round(2)}%"
    bm.send_message "HeadShot: #{headshot.round(2)}%"
  end

  if bm.content.include? === "register" && !ids[bm.user.id]
    ids[bm.user.id] = bm.content.slice!("register ")
  end

  if bm.content === "delete ID"
    ids.delete(bm.user.id)
  end
end

bot.run
