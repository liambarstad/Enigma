class Encryptor
  attr_accessor :key, :final_key
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


  def make_final_key
    key_array = get_values(@key, 2, 1)
    offset_array = get_values(@offset, 1, 1)
    final_string = ""
    for i in (0..3)
      final_string += (key_array[i].to_i - offset_array[i].to_i).to_s
    end
    final_string
  end
end
