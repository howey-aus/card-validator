require 'test/unit'
require 'lib/credit_card/credit_card'

class TestCreditCard < Test::Unit::TestCase
  
  def setup
    
    # Test some 'extreme' data, along with the test data provided.
    @sample_card_data = [
      
      {:number => nil, :expected_type => 'Unknown', :expected_valid => false},
      {:number => '3RECRTC$%GVSW##@$%CVV$%%$V#22222', :expected_type => 'Unknown', :expected_valid => false},
      
      {:number => 4111111111111111, :expected_type => 'Visa', :expected_valid => true},
      {:number => 4111111111111, :expected_type => 'Visa', :expected_valid => false},
      {:number => 4012888888881881, :expected_type => 'Visa', :expected_valid => true},
      {:number => 378282246310005, :expected_type => 'AMEX', :expected_valid => true},
      {:number => 6011111111111117, :expected_type => 'Discover', :expected_valid => true},
      {:number => 5105105105105100, :expected_type => 'MasterCard', :expected_valid => true},
      {:number => '5105 1051 0510 5106', :expected_type => 'MasterCard', :expected_valid => false},
      {:number => 9111111111111111, :expected_type => 'Unknown', :expected_valid => false}
      
    ]
  end
  
  def test_types
    
    @sample_card_data.each do |sample|
      card = CreditCard::CreditCard.new(sample[:number])
      assert_equal(sample[:expected_type], card.type)
    end
    
  end
  
  def test_validity
    
    @sample_card_data.each do |sample|
      card = CreditCard::CreditCard.new(sample[:number])
      assert_equal(sample[:expected_valid], card.valid?)
    end
    
  end
  
end