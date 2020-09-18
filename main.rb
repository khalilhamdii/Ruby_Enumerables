module Enumerable
  # 1 - my_each code

  def my_each
    input_arr = *self
    input_length = input_arr.length

    return to_enum(:my_each) unless block_given?

    (0...input_length).each do |j|
      yield(input_arr[j])
    end
    self
  end

  # 2 - my_each_with_index

  def my_each_with_index
    input_arr = *self
    input_length = input_arr.length

    return to_enum(:my_each_with_index) unless block_given?

    (0...input_length).each do |j|
      yield(input_arr[j], j)
    end
    self
  end

  # 3 my_select

  def my_select
    selected_arr = []
    return to_enum(:my_each_with_index) unless block_given?

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
      elsif (item == condition) || (item && condition.nil?)
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
      elsif item && condition.nil?
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
      if block_given? && myproc.nil?
        new_arr.push(yield(item))
      elsif (block_given? && myproc) || (!block_given? && myproc)
        new_arr.push(myproc.call(item))
      else return to_enum(:my_map)
      end
    end
    new_arr
  end

  # 9 - my_inject code

  def my_inject(*args)
    arg1, arg2 = args

    if block_given?
      accumulator = arg1
      my_each do |item|
        accumulator = !accumulator ? item : yield(accumulator, item)
      end
    elsif arg1.is_a?(Symbol) || arg1.is_a?(String)
      accumulator = false
      my_each do |item|
        accumulator = !accumulator ? item : accumulator.send(arg1, item)
      end
    elsif arg2.is_a?(Symbol) || arg2.is_a?(String)
      accumulator = arg1
      my_each do |item|
        accumulator = !accumulator ? item : accumulator.send(arg2, item)
      end
    else return to_enum(:my_inject)
    end
    accumulator
  end
end

# 10 - multiply_els code

def multiply_els(arr)
  arr.my_inject(1, :*)
end
