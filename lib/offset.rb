class Offset
  attr_accessor :date, :offset
  def initialize
    @date = Time.now.strftime("%d/%m/%y")
    @offset = get_offset
  end

  def remove_backslash(date)
    date.gsub('/',"")
  end

  def date_integer_squared
    (remove_backslash(@date).to_i ** 2).to_s
  end

  def get_offset
    date_integer_squared[-4..-1]
  end
end
