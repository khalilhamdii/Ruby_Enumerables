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

end



# 1 *** my_each test

["A","B1","c","e","dad","eeeee"].my_each { |item| puts  item.length }


