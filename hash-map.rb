class HashMap
  @@bucket = Array.new(16)

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    hash_code = hash(key)
    index = hash_code % 16
    @@bucket[index] = {key => value}
  end

  def get(key)
    hash_code = hash(key)
    index = hash_code % 16
    @@bucket[index].nil? ? nil : @@bucket[index][key]
  end
end
