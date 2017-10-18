const Eris = require("eris");

var bot = new Eris("LyA9hwevrWN6PHW4-Z2pAxuRaLRaLN-S");
//Botのトークンを書き換えておいてください。

bot.on("ready", () => { // Botが起動出来たら
console.log("Ready!"); // コンソールにReady! と書かれます。
});

bot.on("messageCreate", (msg) => //誰かが発言したときに起こるイベントです
{
if(!msg.author.bot) //コマンド実行者がBotでないとき
{
if(msg.content === "!ping") //もし、受け取ったのが!pingなら、
{
bot.createMessage(msg.channel.id, "Pong!"); //Pong!と返す
} 
else if(msg.content === "!pong") //もし、受け取ったのが!pingではなく!pongなら、
{ 
bot.createMessage(msg.channel.id, "Ping!"); //Ping!と返す
}
}
});

bot.connect(); // Discordに接続します。