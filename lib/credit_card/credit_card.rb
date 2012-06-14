module CreditCard
  CARD_METADATA = {
    amex: {type: 'AMEX', prefixes: ['34','37'], lengths: [15]},
    discover: {type: 'Discover', prefixes: ['6011'], lengths: [16]},
    mastercard: {type: 'MasterCard', prefixes: ('51'..'55').to_a, lengths: [16]},
    visa: {type: 'Visa', prefixes: ['4'], lengths: [13,16]}
  }

  class CreditCard
    attr_accessor :number
    attr_accessor :type
  
    def initialize(number)
      @number = number.to_s.gsub(/ /, '')
      @type = get_type
    end
  
    def valid?
      @type != 'Unknown' and luhn_valid?
    end
  
    private
    
    def get_type
      
      type = 'Unknown'
      
      # For each card type in the metadata,
      # check the prefix and length and assign a type
      CARD_METADATA.each do |card,metadata|
        metadata[:prefixes].each do |prefix|
          if (@number[0,prefix.length] == prefix) and (metadata[:lengths].include? @number.length)
            type = metadata[:type]
            break
          end
        end
      end
      
      type
      
    end
  
    def luhn_valid?
    
      # 1. Starting with the next to last digit and continuing with 
      # every other digit going back to the beginning of the card, double the digit.
      index = -1
      numbers_to_add = @number.split('').reverse.collect do |n|
        index += 1
        index % 2 != 0 ? n.to_i*2 : n.to_i # Either doubled or as-is, depending on index.
      end

      # 2. Sum all doubled and untouched digits in the number.
      # For digits greater than 9 you will need to split them
      # and sum the independently (i.e. "10", 1 + 0).
      total = numbers_to_add.inject do |sum,n|
        if n >= 10
          n_string = n.to_s
          n = n_string.split('').inject {|s,el| s.to_i + el.to_i}
        end
        sum + n
      end
    
      # 3. If that total is a multiple of 10, the number is valid.
      total % 10 == 0
    
    end
  
  end  

end