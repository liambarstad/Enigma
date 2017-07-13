module Reading

  def get_file_string(filename)
    File.read(filename)
  end

  def string_to_4_arrays(strang)
    result_array = [[],[],[],[]]
    char_count = 0
    strang.each_char do |char|
      result_array[char_count % 4] << char
      char_count += 1
    end
    result_array
  end
    # seperates a string into 4 nested arrays, where "abcdefgh" would become
    # [[a, e], [b, f], [c, g], [d, h]]

  def rotate(nested_array)
    new_nested_array = [[], [], [], []]
    for i in 0..3
      nested_array[i].map do |char|
        @final[i].to_i.times do
          char = move_to_next(char)
        end
        new_nested_array[i] << char
      end
    end
    new_nested_array
  end
    # rotates each element in nested array the number of times that the final key indicates

  def move_to_next(char)
    if char.ord == 126
      char = (char.ord - 94).chr
    elsif char.ord == 10
      char = char
    else
      char = (char.ord + 1).chr
    end
    char
  end

  def consolidate(rotated_nested_array)
    encrypted_msg = ""
    rotated_nested_array.cycle(rotated_nested_array[0].size) do |char_array|
      if !(char_array.empty?)
        encrypted_msg += char_array.shift
      end
    end
    encrypted_msg
  end
    # puts rotated array back into string

  def export_msg_to_file(msg, export_filename)
    File.open(export_filename, "w+") do |f|
      f.write msg
    end
  end
      # creates a new file and writes the encrypted message on it
end
