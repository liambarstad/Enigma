require './lib/writer.rb'
require 'minitest/autorun'

class WriterTest < Minitest::Test

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
    writer.encrypt_file("./data/test_2.txt", "./data/test_1.txt")
    output = File.read("./data/test_1.txt")
    assert_equal "6($x=\n", output
  end
end
