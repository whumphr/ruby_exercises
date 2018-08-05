module Enumerable
  
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
    self
  end


  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    self
  end


  def my_map
    new_array = []
    self.my_each {|x| new_array << yield(x) }
    return new_array
  end


  def my_count
    count = 0
    self.my_each do |x|
        if block_given?
          if yield x
            count += 1
          end
        else
            count += 1
        end
    end
    return count
  end


  def my_select
    new_array = []
    self.my_each {|x| new_array << x if yield(x)}
    return new_array
  end


  def my_all? #Handles comparisons that otherwise throw errors such as String > 0
    result = true
    begin
        self.my_each do |x| 
            if yield(x) == true
                result = true
            else
                result = false
                break            
            end
        end
    rescue => exception
        result = false    
    end
    return result
  end


  def my_any?
    result = false
    self.my_each {|x| result = true if yield(x) == true }
    return result
  end


  def my_none?
    result = true
    self.my_each {|x| result = false if yield(x) == true}
    return result
  end


  def my_inject
    acc = self[0]
    self.drop(self[0]).each do |x|
        acc = yield(x, acc)
    end
    return acc
  end


end 


#arr = [1, 2, "hi", 4, true]
arr = [1, 2, 3, 4, 5]
triple = Proc.new {|x| x * 3}

#p arr.my_each {|x| puts x + 1}

#p arr.my_map{|x| x * 2 }
#p arr.my_map(&triple)
#p arr.my_count
#p arr.my_count {|x| x > 2}
#p arr.my_select {|x| x % 2 == 0}
#p arr.my_all? {|x| x > 0}
#p arr.my_any? {|x| x == 2}
#p arr.my_none? {|x| x == 2}
#p arr.my_inject { |x, acc| acc * x }
