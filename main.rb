module Enumerable
  # 1 - my_each code

  def my_each
    input_arr = *self
    input_length = input_arr.length
    
      unless block_given?
       return to_enum(:my_each)
      end

        for j in 0...input_length
          yield(input_arr[j])
          end 
    self    
  end

  # 2 - my_each_with_index

  def my_each_with_index
    input_arr = *self
    input_length = input_arr.length
    
      unless block_given?
       return to_enum(:my_each_with_index)
      end

        for j in 0...input_length
          yield(input_arr[j],j)
          end 
    self    
  end

  # 3 my_select

  def my_select
    selected_arr = []
    unless block_given?
      return to_enum(:my_each_with_index)
     end
    my_each do |item|
      next unless yield(item)

      selected_arr.push(item)
    end
    selected_arr
  end

  # 4 - my_all? code

  def my_all?(condition = nil)
    my_each do |item|
      if block_given?
        return false unless yield(item)
      elsif condition.class == Class
        return false unless item.is_a?(condition)
      elsif condition.class == Regexp
        return false unless item.match(condition)
      elsif item != condition
        return false
      end
    end
    true
  end

  # 5 - my_any? code

  def my_any?(condition = nil)
    my_each do |item|
      if block_given?
        return true if yield(item)
      elsif condition.class == Class
        return true if item.is_a?(condition)
      elsif condition.class == Regexp
        return true if item.match(condition)
      elsif (item == condition) || (item && condition == nil)
        return true
      end
    end
    false
  end

  # 6 - my_none? code

  def my_none?(condition = nil)
    my_each do |item|
      if block_given?
        return false if yield(item)
      elsif condition.class == Class
        return false if item.is_a?(condition)
      elsif condition.class == Regexp
        return false if item.match(condition)
      elsif  item && condition == nil
        return false
      end
    end
    true
  end

  # 7 - my_count code

  def my_count(counter = nil)
    arr = *self
    if counter
      temp_arr = my_select { |item| item == counter }
      return temp_arr.length
    elsif block_given?
      temp_arr = my_select { |item| yield(item) }
      return temp_arr.length
    end
    arr.length
  end

  # 8 - my_map code

  def my_map(myproc = nil)
    new_arr = []
    my_each do |item|
      if block_given? && myproc == nil
        new_arr.push(yield(item))
      elsif (block_given? && myproc) || ( !block_given? && myproc)
        new_arr.push(myproc.call(item)) 
      else return to_enum(:my_map)
      end
    end
    new_arr
  end

  # 9 - my_inject code

  def my_inject(*args)

arg1,arg2 = args

    if block_given? && arg1 == nil
      puts "1 ON"
      acumulator = 0
      my_each do |item|
          acumulator = yield(acumulator, item)
      end
    elsif block_given? && arg1.class == Integer
      puts "2 ON"
      acumulator = arg1
      my_each do |item|
        acumulator = yield(acumulator, item)
      end
    elsif !block_given? && arg1 == :+
      puts "3 ON"
      acumulator = 0
      my_each do |item|
        acumulator += item
      end
    elsif !block_given? && arg1 == :*
      puts "3 ON"
      acumulator = 1
      my_each do |item|
        acumulator *= item
      end

    elsif !block_given? && arg1.class == Integer && arg2 == :*
      puts "4 ON"
      acumulator = arg1
      my_each do |item|
        acumulator *= item
      end
    elsif !block_given? && arg1.class == Integer && arg2 == :+
      puts "5 ON"
      acumulator = arg1
      my_each do |item|
        acumulator += item
      end
    # elsif !block_given? && arg1.class = proc
    #   my_each do |item|
    #     acumulator = self[0]
    #     acumulator = arg1.call(acumulator,item)
    #   end
    end
    acumulator
  end

end

# 10 - multiply_els code

def multiply_els(arr)
  product = arr.my_inject(10) { |accumulator, element| accumulator * element }

  product
end


a = [5, 3, 3, 2, 4, 8, 3, 6, 5, 0, 1, 5, 1, 4, 0, 1, 0, 4, 0, 8, 4, 8, 6, 7, 8, 4, 0, 0, 6, 1, 0, 8, 4, 0, 6, 2, 4, 6, 0, 5, 3, 0, 2, 3, 4, 8, 7, 5, 6, 8, 8, 3, 0, 8, 3, 1, 8, 4, 4, 2, 6, 6, 2, 5, 6, 4, 4, 2, 3, 2, 7, 7, 1, 8, 2, 5, 4, 8, 7, 3, 1, 0, 5, 7, 1, 5, 1, 5, 1, 5, 1, 0, 0, 8, 7, 1, 1, 1, 4, 3] 

range = Range.new(5, 50) 

words = %w[dog door rod blade]

search = proc { |memo, word| memo.length > word.length ? memo : word }

# 1 *** my_each test

# ["A","B1","c","e","dad","eeeee"].my_each { |item| puts  item.length }
# a.my_each {|item| print item}
# puts a.my_each.is_a?(Enumerator)
# block = proc { |num| num < 4 }
# print a.my_each(&block)

# print range.my_each(&block)

# 2 ***my_each_with_index

# ["any","k","a","b","c","d","e"].my_each_with_index { |item,index|
#   puts "#{item} : #{index}"}
# a.my_each_with_index {|item,index| puts "#{item} & #{index}"}
# puts a.my_each_with_index.is_a?(Enumerator)
# block = proc { |num| num < 4 }
# print a.my_each_with_index(&block)

# 3 *** my_select test

# print a.my_select { |num| num.even?}
# print a.my_select.is_a?(Enumerator)

# # 4 *** my_all? test

# puts %w[ant bear cat].my_all? { |word| word.length >= 3 }
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 }
# puts %w[ant bear cat].my_all?(/t/)
# puts [1, 2i, 3.14].my_all?(Numeric)
# puts [nil, true, 99].my_all?
# puts [].my_all?
# puts a.my_all?(3)

# # 5 *** my_any? test

# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].my_any?(/d/)                        #=> false
# puts [nil, true, 99].my_any?(Integer)                     #=> true
# puts [nil, true, 99].my_any?                              #=> true
# puts [].my_any?                                           #=> false
# puts words.my_any?('cat')                                 #=> false

# # 6 *** my_none? test

# puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# puts %w{ant bear cat}.my_none?(/d/)                        #=> true
# puts [1, 3.14, 42].my_none?(Float)                         #=> false
# puts [].my_none?                                           #=> true
# puts [nil].my_none?                                        #=> true
# puts [nil, false].my_none?                                 #=> true
# puts [nil, false, true].my_none?                           #=> false
# puts words.my_none?(5)                                     #=> true

# # 7 *** my_count? test

# ary = [1, 2, 4, 2]
# puts ary.my_count               #=> 4
# puts ary.my_count(2)            #=> 2
# puts ary.my_count{ |x| x%2==0 } #=> 3
# puts range.my_count             #=> 46

# # 8 *** my_map test

# print (1..4).my_map { |i| i * i } #=> [1, 4, 9, 16]
# random_proc = proc { |num| num * 2 }
# print (1..4).my_map(random_proc) #=> [2, 4, 6, 8]
# puts a.my_map.is_a?(Enumerator) #=> true 
# my_proc = proc { |num| num > 10 }
# print a.my_map(my_proc) { |num| num < 10 }

# # 9 *** my_inject test

# #Sum some numbers
# puts (5..10).my_inject(:+)                             #=> 45
# # Same using a block and inject
# puts (5..10).my_inject { |sum, n| sum + n }            #=> 45
# # Multiply some numbers
# puts (5..10).my_inject(1, :*)                          #=> 151200
# # Same using a block
# puts (5..10).my_inject(1) { |product, n| product * n } #=> 151200

# puts range.my_inject(:*)
# puts range.my_inject(2,:*)

search = proc { |memo, word| memo.length > word.length ? memo : word }
words = ["dog", "doooooor", "rod", "blade"] 


puts words.my_inject(&search)



# # 10 *** multiply_els test

# puts multiply_els([2,4,5])
