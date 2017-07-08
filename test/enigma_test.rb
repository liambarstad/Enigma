require 'minitest/autorun'
require 'minitest/pride'
require '../lib/enigma.rb'



class EnigmaTest < Minitest::Test

  def test_date
    enigma = Enigma.new

    assert_equal Time.now.strftime('%m/%d/%y'), enigma.date
  end

  def test_date_convert_integer
    enigma = Enigma.new

    assert_equal Time.now.strftime('%m/%d/%y').to_i, enigma.date_convert_integer
  end
end
