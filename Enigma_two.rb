class Enigma

  attr_accessor :date

  def initialize
    @date = Time.now.strftime('%m/%d/%y')
  end

  def remove_backslash
    date_string = Time.now.strftime('%m/%d/%y').gsub('/',"")
  end

  def date_convert_integer
    date_integer = Time.now.strftime('%m%d%y').to_i
  end

  def date_integer_squared(date_integer)
    squared_date = (date_integer ** 2)
  end

  def convert_to_string(squared_date)
    offset = squared_date.to_s
  end

  def get_offset(offset)
    offset_key = offset[-4..-1]
  end
end
