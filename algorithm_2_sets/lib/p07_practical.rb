require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
    hash = HashMap.new
    arr=string.chars
    idx = 0
    while(idx < arr.length - 1 )
      currentLetter = arr[idx]
      if hash.include?(currentLetter)
        hash.set(currentLetter,nil)
      else
        hash.set(currentLetter,true)
      end
      idx+=1
    end
    lastLetter=arr[idx]
    if arr.length.even?
      !!hash.get(lastLetter)
    else
      !!hash.get(lastLetter)
    end
end
