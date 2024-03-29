#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'credit_card/credit_card'

message = "Enter a card number (or 'exit' to exit): "
print message
while (number = gets) != "exit\n"
  card = CreditCard::CreditCard.new(number.chomp)
  valid = card.valid? ? 'valid' : 'invalid'
  puts "#{card.type}: #{card.number} (#{valid})"
  print message
end