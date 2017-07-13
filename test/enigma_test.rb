require 'minitest'
require 'minitest/autorun'
require './lib/enigma.rb'

class EnigmaTest < Minitest::Test

  def test_get_digits
    encryptor = Enigma.new
    assert_equal encryptor.key.key[0], encryptor.get_digits(encryptor.key.key, 1)
  end

  def test_get_digits_2
    encryptor = Enigma.new
    assert_equal encryptor.key.key[0..1], encryptor.get_digits(encryptor.key.key, 2)
  end

  def test_get_values_test
    encryptor = Enigma.new
    arr = []
    for i in 0..(encryptor.key.key.length - 1)
      arr << encryptor.key.key[i]
    end
    assert_equal arr, encryptor.get_values(encryptor.key.key, 1, 1)
  end

  def test_get_values_2
    encryptor = Enigma.new
    arr = []
    operating_key = "" + encryptor.key.key
    until operating_key.length < 2
      arr << operating_key[0..1]
      operating_key.slice!(0)
    end
    assert_equal arr, encryptor.get_values(encryptor.key.key, 2, 1)
  end

  def test_difference_of_chars
    encryptor = Enigma.new
    assert_equal "2", encryptor.difference_of_chars("2", "4")
  end

  def test_dont_add_zero_if_greater_than_10
    encryptor = Enigma.new
    str = "12"
    assert_equal "12", encryptor.add_zero_if(str)
  end

  def test_add_zero_if_less_than_10
    encryptor = Enigma.new
    str = "9"
    assert_equal "09", encryptor.add_zero_if(str)
  end

  def test_add_two_zeros_if
    encryptor = Enigma.new
    str = "0"
    assert_equal "00", encryptor.add_two_zeros_if(str)
  end

  def test_make_final_key
    encryptor = Enigma.new
    key = "10000"
    offset = "1000"
    encryptor.final_key = encryptor.make_final_key(key, offset)
    assert_equal "09000000", encryptor.final_key
  end

  def test_make_final_key_2
    encryptor = Enigma.new
    encryptor.key.key = "12345"
    key = "12345"
    encryptor.offset.offset = "1234"
    offset = "1234"
    encryptor.final_key = encryptor.make_final_key(key, offset)
    assert_equal "11213141", encryptor.final_key
  end

  def test_make_new_writer_key_default
    encryptor = Enigma.new
    writer = encryptor.make_new_writer(encryptor.key.key, encryptor.offset.date)
    assert_equal encryptor.key.key, writer.key
  end

  def test_make_new_writer_date_default
    encryptor = Enigma.new
    writer = encryptor.make_new_writer(encryptor.key.key, encryptor.offset.date)
    assert_equal encryptor.offset.date, writer.date
  end

  def test_make_new_writer_final_key_default
    encryptor = Enigma.new
    writer = encryptor.make_new_writer(encryptor.key.key, encryptor.offset.date)
    final_key = encryptor.get_values(encryptor.final_key, 2, 2)
    assert_equal final_key, writer.final
  end

  def test_make_new_offset
    encryptor = Enigma.new
    new_offset = encryptor.make_new_offset("08/12/1996")
    assert_equal "4016", new_offset.offset
  end

  def test_make_new_writer_key_user_inputted
    encryptor = Enigma.new
    key = "10000"
    date = "08/12/1996"
    writer = encryptor.make_new_writer(key, date)
    assert_equal key, writer.key
  end

  def test_make_new_writer_date_user_inputted
    encryptor = Enigma.new
    key = "10000"
    date = "08/12/1996"
    writer = encryptor.make_new_writer(key, date)
    assert_equal date, writer.date
  end

  def test_make_new_writer_final_key_user_inputted
    encryptor = Enigma.new
    key = "12345"
    date = "08/12/1996"
    writer = encryptor.make_new_writer(key, date)
    assert_equal ["08", "23", "33", "39"], writer.final
  end

  def test_check_nil_key
    encryptor = Enigma.new
    nil_key = encryptor.check_key_if_nil(nil)
    assert_equal encryptor.key.key, nil_key
  end

  def test_check_new_key
    encryptor = Enigma.new
    stuff_key = encryptor.check_key_if_nil("12345")
    assert_equal "12345", stuff_key
  end

  def test_check_nil_date
    encryptor = Enigma.new
    nil_date = encryptor.check_date_if_nil(nil)
    assert_equal encryptor.offset.date, nil_date
  end

  def test_check_new_date
    encryptor = Enigma.new
    stuff_date = encryptor.check_date_if_nil("08/12/1996")
    assert_equal "08/12/1996", stuff_date
  end

  def test_encrypt_default
    encryptor = Enigma.new
    encryptor.final_key = "12233445"
    message = "hello"
    encrypted_msg = encryptor.encrypt(message)
    assert_equal "t|/:{", encrypted_msg
  end

  def test_encrypt_key_user_inputted
    encryptor = Enigma.new
    message = "hello"
    encryptor.offset.date = "08/12/1996"
    encryptor.offset.offset = "1998"
    encrypted_msg = encryptor.encrypt(message, "12345")
    assert_equal "p|.4w", encrypted_msg
  end

  def test_encrypt_date_user_inputted
    encryptor = Enigma.new
    message = "hello"
    encrypted_msg = encryptor.encrypt(message, "12345", "08/12/1996")
    assert_equal "p|.4w", encrypted_msg
  end

  def test_encrypt_file
    encryptor = Enigma.new
    encryptor.encrypt_file("./data/test_2.txt", "./data/test_1.txt")
  end

  def test_decrypt_default
    encryptor = Enigma.new
    encryptor.final_key = "12233445"
    message = "t|/:{"
    decrypted_msg = encryptor.decrypt(message)
    assert_equal "hello", decrypted_msg
  end

  def test_decrypt_new_key
    encryptor = Enigma.new
    message = "p|.4w"
    encryptor.offset.date = "08/12/1996"
    encryptor.offset.offset = "1998"
    decrypted_msg = encryptor.decrypt(message, "12345")
    assert_equal "hello", decrypted_msg
  end

  def test_decrypt_new_date_and_key
    encryptor = Enigma.new
    message = "p|.4w"
    decrypted_msg = encryptor.decrypt(message, "12345", "08/12/1996")
    assert_equal "hello", decrypted_msg
  end

  def test_decrypt_file
    encryptor = Enigma.new
    encryptor.decrypt_file("./data/test_1.txt", "./data/test_2.txt")
  end
end
