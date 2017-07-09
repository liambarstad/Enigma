require 'minitest/autorun'
require 'minitest/pride'
require '../lib/enigma.rb'



class EnigmaTest < Minitest::Test

  def test_date
    enigma = Enigma.new

    assert_equal Time.now.strftime('%m/%d/%y'), enigma.date
  end

  def test_remove_backslash
    enigma = Enigma.new

    assert_equal Time.now.strftime('%m%d%y'), enigma.remove_backslash
  end

  def test_date_convert_integer
    enigma = Enigma.new

    assert_equal Time.now.strftime('%m%d%y').to_i, enigma.date_convert_integer
  end

  def test_date_integer_squared
    enigma = Enigma.new
    date_integer = Time.now.strftime('%m%d%y').to_i

    assert_equal (date_integer ** 2) , enigma.date_integer_squared(date_integer)
  end

  def test_convert_to_string
    enigma = Enigma.new
    date_integer = Time.now.strftime('%m%d%y').to_i
    squared_date = (date_integer ** 2)

    assert_equal squared_date.to_s, enigma.convert_to_string(squared_date)
  end

  def test_isolate_last_four_numbers_in_array
    enigma = Enigma.new
    date_integer = Time.now.strftime('%m%d%y').to_i
    squared_date = (date_integer ** 2)
    offset = squared_date.to_s

    assert_equal offset[-4..-1], enigma.get_offset(offset)
  end
end
