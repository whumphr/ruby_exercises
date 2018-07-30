def bubble_sort(arr)
    j = 1
    while j != 0
        changes = 0
        i = 0
        while i < arr.length - 1 
            if arr[i] > arr[i+1]
                arr[i], arr[i+1] = arr[i+1], arr[i]
                i += 1
                changes += 1   
            else
                i += 1    
            end
        end
        j = changes
    end
    arr
end

print bubble_sort([4,3,78,2,0,2]).to_s + "\n"
print bubble_sort([1, 2, 3, 4, 6, 5]).to_s + "\n"
print bubble_sort([5, 4, 3, 2, 1]).to_s + "\n"