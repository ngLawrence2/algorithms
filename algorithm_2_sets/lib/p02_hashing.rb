class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    res = 0
    self.each_with_index do |k,idx|
      res+= (k^idx)
    end
    res.hash
  end
end

class String
  def hash
    res = 0
    self.chars.each_with_index do |k,idx|
      res += (k.ord ^ idx)
    end
    res.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    res = 0
    self.keys.each do |k|
      res += (k.hash ^ self[k].hash)
    end
    res.hash
  end
end
