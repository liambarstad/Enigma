require_relative 'decryptor'
require_relative 'offset'
require_relative 'key_gen'

class Enigma
  attr_accessor :key, :offset, :final_key
  def initialize
    @offset = Offset.new
    @key = KeyGen.new
    @final_key = make_final_key(@key.key, @offset.offset)
  end

  def encrypt(message, key=nil, date=nil)
    writer = make_new_writer(check_key_if_nil(key), check_date_if_nil(date))
    p "#{writer.encrypt_message(message)}"
  end

  def encrypt_file(in_file, out_file)
    writer = Writer.new(@key.key, @offset.date, get_values(@final_key, 2, 2))
    writer.encrypt_file(in_file, out_file)
  end

  def make_new_writer(key, date)
    if key == @key.key && date == @offset.date
      Writer.new(key, date, get_values(@final_key, 2, 2))
    else
      off = make_new_offset(date)
      Writer.new(key, date, get_values(make_final_key(key, off.offset), 2, 2))
    end
  end

  def make_new_offset(date)
    off = Offset.new
    off.date = date
    off.offset = off.get_offset
    off
  end

  def decrypt(message, key=nil, date=nil)
    reader = make_new_reader(check_key_if_nil(key), check_date_if_nil(date))
    reader.decrypt_message(message)
  end

  def decrypt_file(in_filename, out_filename)
    reader = Decryptor.new(@key.key, @offset.date, get_values(@final_key, 2, 2))
    reader.decrypt_file(in_filename, out_filename)
  end

  def make_new_reader(key, date)
    if key == @key.key && date == @offset.date
      Decryptor.new(key, date, get_values(@final_key, 2, 2))
    else
      off = Offset.new
      off.date = date
      Decryptor.new(key, date, get_values(key, off.offset), 2, 2)
    end
  end

  def check_key_if_nil(key)
    if key.nil?
      @key.key
    else
      key
    end
  end

  def check_date_if_nil(date)
    if date.nil?
      @offset.date
    else
      date
    end
  end

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

  def make_final_key(key, offset)
    key_array = get_values(key, 2, 1)
    offset_array = get_values(offset, 1, 1)
    final_string = ""
    for i in (0..3)
      final_string += add_zero_if(add_two_zeros_if(difference_of_chars(key_array[i], offset_array[i])))
    end
    final_string
  end
end
