require_relative 'writer'

class Decryptor
  def initialize(key, date, final)
    @key = key
    @date = date
    @final = final
  end
  include Reading

  def decrypt_message(message)
    nested_array = string_to_4_arrays(message)
    rotated_array = reverse_rotate(nested_array)
    consolidated_str = consolidate(rotated_array)
    p "#{consolidated_str}"
  end

  def decrypt_file(in_filename, out_filename)
    strang = get_file_string(in_filename)
    nested_array = string_to_4_arrays(strang)
    rotated_array = reverse_rotate(nested_array)
    consolidated_str = consolidate(rotated_array)
    export_msg_to_file(consolidated_str, out_filename)
    print_decryption_msg(in_filename)
  end

  def reverse_rotate(nested_array)
    new_nested_array = [[], [], [], []]
    for i in 0..3
      nested_array[i].map do |char|
        @final[i].to_i.times do
          char = move_to_prev(char)
        end
        new_nested_array[i] << char
      end
    end
    new_nested_array
  end

  def move_to_prev(char)
    if char.ord == 32
      char = (char.ord + 94).chr
    elsif char.ord == 10
      char = char
    else
      char = (char.ord - 1).chr
    end
    char
  end

  def print_decryption_msg(out_filename)
    p "Decrypted #{out_filename} with the key #{@key} and the date #{@date}"
  end
end
