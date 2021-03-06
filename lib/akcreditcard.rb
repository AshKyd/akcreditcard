# This class takes a credit card number and performs a Luhn validation.
# Author:: Ash Kyd (ash@kyd.com.au)
# Copyright:: Copyright (2012) Ash Kyd

require "akluhnalgorithm"

class AKCreditCard
  # Include this algorithm, since it's 
  include AKLuhnAlgorithm
  
  attr_accessor :number
  
  # card_types stores card names and an expression to match against.
  @@card_types = {
    # AMEX begins with 34 or 37. 15 digits
    "AMEX" => /^(34|37)\d{13}$/,
    
    # Discover begins with 6011. 16 digits
    "Discover" => /^6011\d{12}$/,
    
    # MasterCard begins with 51-55. 16 digits
    "MasterCard" => /^5[1-5]\d{14}$/,
    
    # VISA begins with 4. 13 or 16 digits
    "VISA" => /^4\d{12}\d{3}?$/
  }

  def initialize(card_number)
    
    # Set our card number.
    self.number = card_number
    
  end

  # Validate and set the credit card number. A string nor number
  # value, only numeric characters, spaces and dashes accepted.
  def number=(value)
  
    # Let us set a string value in case of direct input.
    if value.class == String
      value = self.card_s_to_i(value)
    end
    
    # And finally set our card number
    @number = value.to_i
    
  end
  
  def type
  
    # Loop through each @@card_types spec and validate against it.
    # If the card matches any card type, return the name.
    @@card_types.each do |spec|
      if spec[1].match(@number.to_s)
        return spec[0]
      end;
    end
    
    # Otherwise, return a defualt value.
    "Unknown"
    
  end
  
  def valid
    if self.validate_luhn(number)
      return "valid"
    else
      return "invalid"
    end
  end

  # A to_s method allows us to print our credit card information back
  # to the terminal.
  def to_s
  
    return "#{type}: #{number}".ljust(29)+"(#{valid})"
    
  end
  
  # Semi-validate syntax and convert a card number to an integer.
  # Accepts numbers, spaces and dashes in any arrangement.
  # Throws :badInput on malformed input.
  def card_s_to_i(value)
  
    # Strip out any leading/trailing whitespace
    value.strip!
    
    # Remove spaces or dashes
    value = value.gsub /[\s-]/,"";
    
    # We have been handed a bad input, this is not in the correct
    # format.
    if value.to_i.to_s != value
      raise "Input not valid"
    end
    
    value.to_i
    
  end

end
