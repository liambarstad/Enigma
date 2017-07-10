gem 'minitest', '~> 5.2'
require_relative 'Enigma.rb'
require 'minitest/autorun'
require 'minitest/pride'

class EnigmaTest < Minitest::Test

  def test_make_new_key
    encryptor = Encryptor.new
    assert encryptor.key.is_a?(String)
    assert_equal encryptor.key.length, 5
  end

  def test_get_digits
    encryptor = Encryptor.new
    assert_equal encryptor.key[0], encryptor.get_digits(encryptor.key, 1)
  end

  def test_get_digits_2
    encryptor = Encryptor.new
    assert_equal encryptor.key[0..1], encryptor.get_digits(encryptor.key, 2)
  end

  def test_get_values_test
    encryptor = Encryptor.new
    arr = []
    for i in 0..(encryptor.key.length - 1)
      arr << encryptor.key[i]
    end
    assert_equal encryptor.get_values(encryptor.key, 1, 1), arr
  end

  def test_get_values_2
    encryptor = Encryptor.new
    arr = []
    operating_key = "" + encryptor.key
    until operating_key.length < 2
      arr << operating_key[0..1]
      operating_key.slice!(0)
    end
    assert_equal arr, encryptor.get_values(encryptor.key, 2, 1)
  end

  def test_difference_of_chars
    encryptor = Encryptor.new
    assert_equal "2", encryptor.difference_of_chars("2", "4")
  end

  def test_dont_add_zero_if_greater_than_10
    encryptor = Encryptor.new
    str = "12"
    assert_equal "12", encryptor.add_zero_if(str)
  end

  def test_add_zero_if_less_than_10
    encryptor = Encryptor.new
    str = "9"
    assert_equal "09", encryptor.add_zero_if(str)
  end

  def test_add_two_zeros_if
    encryptor = Encryptor.new
    str = "0"
    assert_equal "00", encryptor.add_two_zeros_if(str)
  end

  def test_make_final_key
    encryptor = Encryptor.new
    encryptor.key = "10000"
    encryptor.offset = "1000"
    binding.pry
    encryptor.final_key = encryptor.make_final_key
    assert_equal "09000000", encryptor.final_key
  end

  def test_make_final_key_2
    encryptor = Encryptor.new
    encryptor.key = "12345"
    encryptor.offset = "1234"
    encryptor.final_key = encryptor.make_final_key
    assert_equal "11213141", encryptor.final_key
  end
end
