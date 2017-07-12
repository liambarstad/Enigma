gem 'minitest', '~> 5.2'
require '../lib/writer'
require 'minitest/autorun'

class WriterTest < Minitest::Test

  def test_get_file_string
    writer = Writer.new(0, 0, 0)
    assert_equal "hello\n", writer.get_file_string("../data/test_2.txt")
  end

  def test_string_to_4_arrays
    writer = Writer.new(0, 0, 0)
    strang = "hello"
    assert_equal [["h", "o"], ["e"], ["l"], ["l"]], writer.string_to_4_arrays(strang)
  end

  def test_move_to_next
    writer = Writer.new(0, 0, 0)
    char_126 = writer.move_to_next("~")
    assert_equal " ", char_126
  end

  def test_rotate
    writer = Writer.new(0, 0, [12, 23, 34, 45])
    nested_array = [["h", "o"], ["e"], ["l"], ["l"]]
    assert_equal [["t", "{"], ["|"], ["/"], [":"]], writer.rotate(nested_array)
  end

  def test_consolidate
    writer = Writer.new(0, 0, 0)
    nested_array = [["h", "o"], ["e"], ["l"], ["l"]]
    assert_equal "hello", writer.consolidate(nested_array)
  end

  def test_export_msg_to_file
    writer = Writer.new(0, 0, 0)
    random_number = rand(0..100)
    writer.export_msg_to_file(random_number, "../data/test_1.txt")
    contents = File.read("../data/test_1.txt")
    assert_equal random_number.to_s, contents
  end

  def test_print_encryption_msg
    writer = Writer.new(12345, 12081996, 0)
    assert_equal "Created 'file' with encryption key 12345 and date 12081996", writer.print_encryption_msg("file")
  end

  def test_encrypt_message
    writer = Writer.new(0, 0, [12, 23, 34, 45])
    message = "hello"
    encrypted_msg = writer.encrypt_message(message)
    assert_equal "t|/:{", encrypted_msg
  end

  def test_encrypt_file
    writer = Writer.new(12345, 12081996, [45, 34, 23, 12])
    writer.encrypt_file("../data/test_2.txt", "../data/test_1.txt")
    output = File.read("../data/test_1.txt")
    assert_equal "6($x=\n", output
  end
end
