class Array

    def my_each(&prc)
        i = 0

        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        array = []
        self.my_each do |ele|
            if prc.call(ele)
                array << ele
            end
        end
        array
    end

    def my_reject(&prc)
        self.my_select do |ele|
            !prc.call(ele)
        end
    end

    def my_any?(&prc)
        self.my_each do |ele|
            return true if prc.call(ele)
        end
        false 
    end

    def my_all?(&prc)
        self.my_each do |ele|
            return false if !prc.call(ele)
        end
        true
    end

    def my_flatten
        better_flatten(self)
    end

    def better_flatten(data)
        return [data] unless data.is_a?(Array)
        flat = []
        data.my_each do |ele|
            flat += better_flatten(ele)
        end
    end

    def my_zip(*arg)
        # arr = Array.new(self.length) { Array.new(arg.length+1) { ' ' } }
        arg.unshift(self)
        arr = Array.new(self.length) { [] }
        (0..arg.length-1).to_a.my_each do |idx|
            arg.my_each do |sub_arr|
                unless arr[idx].nil?
                    arr[idx] << sub_arr[idx]
                end
            end
        end
        arr
    end

    def my_rotate(num = 1)
        if num < 0 
            (num.abs).times { self.unshift(self.pop) } 
            return self
        elsif num > 0
            num.times { self << self.shift }
            return self
        end
    end

    def my_join(sep = '')
        str = ''
        self.my_each do |ele|
            str += ele
            unless ele == self[-1]
                str += sep
            end
        end
        str
    end

    def my_reverse
        arr = []
        i = self.length-1
        while i >= 0
            arr << self[i]
            i -= 1
        end
        arr
    end
end

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]




# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]