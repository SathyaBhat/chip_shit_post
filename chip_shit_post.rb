require 'httparty'
require 'yaml'
require 'logger'
require 'sequel'
require_relative 'lib/update'

$log = Logger.new(STDOUT)  
bot_token = YAML.load_file('secrets.yaml')
token = bot_token["chip_shit_post"]["token"]


#while:
  response = HTTParty.get("https://api.telegram.org/bot#{token}/getUpdates")
  $log.debug("Response: #{response}")
  if response['ok']
    result = response['result']
    result.each do |r|
      chats = Update.new
      chats.update_id = r['update_id']
      chats.message_id = r['message']['message_id']
      chats.from_id = r['message']['from']['id']
      chats.from_first_name = r['message']['from']['first_name']
      chats.from_last_name = r['message']['from']['last_name']
      chats.from_username = r['message']['from']['username']
      chats.from_group = r['message']['chat']['title']
      chats.chat_id = r['message']['chat']['id']
      chats.chat_text = r['message']['text']
      if r['message']['forward_from'].nil?
        $log.debug('Not a forwarded message')
        chats.chat_received_date = r['message']['date']
        chats.forwarded_chat = 'N'
      else
        chats.chat_received_date = r['message']['forward_date']
        chats.forwarded_chat = 'Y'
      end

      begin
        chats.save
      rescue Sequel::UniqueConstraintViolation => e
        $log.debug("Warning: Unique constraint error raised on #{chats.update_id}")
      end
    end
  end