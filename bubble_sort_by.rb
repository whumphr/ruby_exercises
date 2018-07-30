def bubble_sort_by(arr)
    changes = 1
    while changes != 0
        change_record = 0
        i = 0
        while i < arr.length - 1
            if yield(arr[i], arr[i+1]) > 0
                arr[i], arr[i+1] = arr[i+1], arr[i]
                i += 1
                change_record += 1   
            else
                i += 1    
            end
        end
        changes = change_record
    end
    arr
end

p bubble_sort_by(["hello", "hi", "hey" ]) {|left, right|left.length - right.length}
