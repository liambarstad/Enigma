require './lib/key_gen.rb'
require 'minitest/autorun'

class KeyGenTest < Minitest::Test

  def test_make_new_key
    key_gen = KeyGen.new
    assert key_gen.key.is_a?(String)
    assert_equal 5, key_gen.key.length
  end
end
