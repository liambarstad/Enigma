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
    assert_equal encryptor.get_digits(encryptor.key, 1), encryptor.key[0]
  end

  def test_get_digits_2
    encryptor = Encryptor.new
    assert_equal encryptor.get_digits(encryptor.key, 2), encryptor.key[0..1]
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
    assert_equal encryptor.get_values(encryptor.key, 2, 1), arr
  end
end
