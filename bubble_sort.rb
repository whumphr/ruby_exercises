def bubble_sort(arr)
    changes = 1
    while changes != 0
        change_record = 0
        i = 0
        while i < arr.length - 1 
            if arr[i] > arr[i+1]
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

p bubble_sort([4,3,78,2,0,2])
p bubble_sort([1, 2, 3, 4, 6, 5])
p bubble_sort([5, 4, 3, 2, 1])

