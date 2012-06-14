#!/usr/bin/env ruby

require 'lib/credit_card/credit_card'

print "Enter a card number: "
while number = gets
  card = CreditCard::CreditCard.new(number.chomp)
  valid = card.valid? ? 'valid' : 'invalid'
  puts "#{card.type}: #{card.number} (#{valid})"
  print "Enter a card number: "
end