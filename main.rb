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
​
      selected_arr.push(item)
    end

  selected_arr
  end
end


# 1 *** my_each test

#["A","B1","c","e","dad","eeeee"].my_each { |item| puts  item.length }

#2 ***my_each_with_index

# ["any","k","a","b","c","d","e"].my_each_with_index { |item,index|
#   puts "#{item} : #{index}"
#   }

# 3 *** my_select test
​
 print [1, 2, 3, 4, 5].my_select { |num| num.even? }
​


