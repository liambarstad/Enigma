require_relative 'reading.rb'

class Writer
  attr_accessor :key, :date, :final
  def initialize(key, date, final)
    @key = key
    @date = date
    @final = final
  end
  include Reading

  def encrypt_message(message)
    nested_array = string_to_4_arrays(message)
    rotated_array = rotate(nested_array)
    consolidated_str = consolidate(rotated_array)
    "#{consolidated_str}"
  end

  def encrypt_file(in_filename, out_filename)
    file_string = get_file_string(in_filename)
    nested_array = string_to_4_arrays(file_string)
    rotated_array = rotate(nested_array)
    consolidated_msg = consolidate(rotated_array)
    export_msg_to_file(consolidated_msg, out_filename)
    p print_encryption_msg(out_filename)
  end

  def print_encryption_msg(output_filename)
    "Created '#{output_filename}' with encryption key #{@key} and date #{@date}"
  end
end
