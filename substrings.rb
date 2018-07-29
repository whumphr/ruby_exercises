def substrings(phrase, dict)
    phrase = phrase.split
    final = {}
    phrase.each {|word| 
        dict.each {|subword| if word.downcase.include?(subword)
            final[subword] = final[subword].to_i + 1
            end}
        }
    puts final
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)
substrings("how how how how how how", dictionary)