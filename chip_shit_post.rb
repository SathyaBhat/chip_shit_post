require 'httparty'
require 'yaml'

bot_token = YAML.load_file('secrets.yaml')
token = bot_token["chip_shit_post"]["token"]

response = HTTParty.get("https://api.telegram.org/bot#{token}/getUpdates")
puts response.body