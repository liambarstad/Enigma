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

  def squared_date_array(squared_date)
    array = [] << squared_date
  end
end
