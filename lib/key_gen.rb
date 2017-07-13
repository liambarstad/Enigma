class KeyGen
  attr_accessor :key
  def initialize
    @key = make_new_key
  end

  def make_new_key
    keyy = ""
    5.times do
      keyy += rand(0..9).to_s
    end
    keyy
  end
end
