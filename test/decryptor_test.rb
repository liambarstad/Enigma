require './lib/decryptor'
require 'minitest/autorun'

class DecryptorTest < Minitest::Test

  def test_move_to_prev
    decryptor = Decryptor.new(0, 0, 0)
    char = "f"
    new_char = decryptor.move_to_prev(char)
    assert_equal "e", new_char
  end

  def test_move_to_prev_to_end
    decryptor = Decryptor.new(0, 0, 0)
    char = " "
    new_char = decryptor.move_to_prev(char)
    assert_equal "~", new_char
  end

  def test_ignore_endline
    decryptor = Decryptor.new(0, 0, 0)
    char = "\n"
    new_char = decryptor.move_to_prev(char)
    assert_equal "\n", new_char
  end

  def test_reverse_rotate
    decryptor = Decryptor.new("test_key", "test_date", ["12", "23", "34", "45"])
    nested_array = [["t", "{"], ["|"], ["/"], [":"]]
    new_nested_array = decryptor.reverse_rotate(nested_array)
    assert_equal [["h", "o"], ["e"], ["l"], ["l"]], new_nested_array
  end

  def test_print_decryption_msg
    decryptor = Decryptor.new("12345", "08/12/1996", "123456")
    msg = "Decrypted test_file with the key 12345 and the date 08/12/1996"
    actual_msg = decryptor.print_decryption_msg("test_file")
    assert_equal msg, actual_msg
  end

  def test_decrypt_message
    decryptor = Decryptor.new("12345", "1234", ["12", "23", "34", "45"])
    message = "hello"
    decrypted_message = decryptor.decrypt_message("t|/:{")
    assert_equal message, decrypted_message
  end

  def test_decrypt_file
    File.open("./data/test_2.txt", "w+") {|f| f.write "t|/:{"}
    decryptor = Decryptor.new("test_key", "test_date", ["12", "23", "34", "45"])
    msg = "Decrypted ./data/test_2.txt with the key test_key and the date test_date"
    actual_msg = decryptor.decrypt_file("./data/test_2.txt", "./data/test_1.txt")
    assert_equal msg, actual_msg
    decrypted_msg = File.read("./data/test_1.txt")
    assert_equal "hello", decrypted_msg
  end
end
