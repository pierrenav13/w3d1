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

    

end

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]