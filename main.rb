# rubocop:disable Style/CaseEquality

module Enumerable

  # 1 - my_each code

  def my_each
    input_arr = [*self]
    input_length = input_arr.length
    for j in 0...input_length
      yield(input_arr[j])
    end
  end

  # 2 - my_each_with_index

  def my_each_with_index
    input_arr = [*self]
    input_length = input_arr.length
    for j in 0...input_length
      yield(input_arr[j], j)
    end
  end

  # 3 my_select

  def my_select
    selected_arr = []
    my_each do |item|
      next unless yield(item)
      selected_arr.push(item)
    end
  selected_arr
  end

  # 4 - my_all? code

  def my_all?(condition=false)

    my_each do |item|
      if block_given?
        unless yield(item)
          return false
        end
      elsif condition.class == Class
        unless item.is_a?(condition)
          return false
        end
      elsif condition.class == Regexp
        unless item.match(condition)
          return false
        end
      elsif !item
        return false
      end
    end
      true
    end

  # 5 - my_any? code

  def my_any?(condition=false)

    my_each do |item|
      if block_given?
        if yield(item)
          return true
        end
      elsif condition.class == Class
        if item.is_a?(condition)
          return true
        end
      elsif condition.class == Regexp
        if item.match(condition)
          return true
        end
      elsif item
        return true
      end
    end
      false
    end

  # 6 - my_none? code

  def my_none?(condition=false)

    my_each do |item|
      if block_given?
        if yield(item)
          return false
        end
      elsif condition.class == Class
        if item.is_a?(condition)
          return false
        end
      elsif condition.class == Regexp
        if item.match(condition)
          return false
        end
      elsif item
        return false
      end
    end
      true
    end

  # 7 - my_count code

  def my_count(counter=false)
  temp_arr = []
  if counter
    temp_arr = my_select { |item| item == counter}
    return temp_arr.length
  elsif block_given?
    temp_arr = my_select { |item| yield(item)}
    return temp_arr.length
  end
  length
  end

   # 8 - my_map code

def my_map
  new_arr = []
  my_each_with_index do |item,index|
    new_arr.push(yield(item,index))
  end
  new_arr
end








end


# 1 *** my_each test

#["A","B1","c","e","dad","eeeee"].my_each { |item| puts  item.length }

#2 ***my_each_with_index

# ["any","k","a","b","c","d","e"].my_each_with_index { |item,index|
#   puts "#{item} : #{index}"
#   }

# 3 *** my_select test

# print [1, 2, 3, 4, 5].my_select { |num| num.even?}

# # 4 *** my_all? test

# puts %w[ant bear cat].my_all? { |word| word.length >= 3 }
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 }
# puts %w[ant bear cat].my_all?(/t/)
# puts [1, 2i, 3.14].my_all?(Numeric)
# puts [nil, true, 99].my_all?
# puts [].my_all?

# # 5 *** my_any? test

# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].my_any?(/d/)                        #=> false
# puts [nil, true, 99].my_any?(Integer)                     #=> true
# puts [nil, true, 99].my_any?                              #=> true
# puts [].my_any?                                           #=> false

# # 6 *** my_none? test

# puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# puts %w{ant bear cat}.my_none?(/d/)                        #=> true
# puts [1, 3.14, 42].my_none?(Float)                         #=> false
# puts [].my_none?                                           #=> true
# puts [nil].my_none?                                        #=> true
# puts [nil, false].my_none?                                 #=> true
# puts [nil, false, true].my_none?                           #=> false

# # 7 *** my_count? test

# ary = [1, 2, 4, 2]
# puts ary.my_count               #=> 4
# puts ary.my_count(2)            #=> 2
# puts ary.my_count{ |x| x%2==0 } #=> 3

# # 8 *** my_map test

print (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
