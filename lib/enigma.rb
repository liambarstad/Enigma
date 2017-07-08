class Enigma

  attr_accessor :date

  def initialize
    @date = Time.now.strftime('%m/%d/%y')
  end

  def date_convert_integer
    Time.now.strftime('%m/%d/%y').to_i
  end


end
