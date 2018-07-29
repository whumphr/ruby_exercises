def stock_picker(arr)
   final = []
   diff = 0
   sell_index = 1
   buy_index = 0
   while sell_index < arr.length - 1
        buy = arr[buy_index]
        sell = arr[sell_index]
        if sell < buy
            buy_index = sell_index
            sell_index += 1
        elsif buy < sell && (sell - buy) > diff
            diff = sell - buy
            final[0] = buy_index
            final[1] = sell_index
            sell_index += 1
        else
            sell_index += 1
        end
    end
    if final.any?
        puts "You should buy on Day #{final[0]} and sell on Day #{final[1]}."
    else
        puts "You probably shouldn't buy unless you're planning on shorting."
    end
end

stock_picker([3,6,9,15,8,6,1,13])
stock_picker([9,8,7,6,5,4,3,2,1])