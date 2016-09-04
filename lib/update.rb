require 'sequel'

Sequel.connect('sqlite://db/chip_shit_post.db')

class Update < Sequel::Model(:received_mesages)
end