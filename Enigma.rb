class Encryptor
  attr_accessor :key, :offset, :final_key
  def initialize
    @key = make_new_key
    @offset = "5632"
    @final_key = make_final_key
  end

  def make_new_key
    keyy = ""
    5.times do
      keyy += rand(0..9).to_s
    end
    keyy
  end
  #outputs random 5 digit number string, this should be initialized with every new instance of Encryptor

  def get_digits(number_string, digits_to_read)
    result_num_string = ""
    for i in (0..(digits_to_read - 1))
      result_num_string += number_string[i]
    end
    result_num_string
  end
  #takes first (digits_to_read) digits out of a number string and outputs them

   def get_values(number_string, digits_to_read, digits_to_slice)
     operating_number = "" + number_string
     result_array = []
     until operating_number.length < digits_to_read
       result_array << get_digits(operating_number, digits_to_read)
       operating_number.slice!(0..(digits_to_slice - 1))
     end
     result_array
   end
  #returns array of numbers after taking first (digits_to_read) digits, then removing the first digit, until
  #there are no more numbers left
  def difference_of_chars(char1, char2)
    (char1.to_i - char2.to_i).abs.to_s
  end

  def add_zero_if(str)
    if str.to_i < 10 && str.length < 2
      "0" + str
    else
      str
    end
  end

  def add_two_zeros_if(str)
    if str.to_i < 1
      "00"
    else
      str
    end
  end

  def make_final_key
    key_array = get_values(@key, 2, 1)
    offset_array = get_values(@offset, 1, 1)
    final_string = ""
    for i in (0..3)
      final_string += add_zero_if(add_two_zeros_if(difference_of_chars(key_array[i], offset_array[i])))
    end
    final_string
  end
end
