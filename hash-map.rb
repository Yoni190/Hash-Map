class HashMap
  @@bucket = Array.new(16)

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    index = get_index(key)
    @@bucket[index] = {key => value}
  end

  def get(key)
    index = get_index(key)
    @@bucket[index].nil? ? nil : @@bucket[index][key]
  end

  def has?(key)
    index = get_index(key)
    @@bucket[index].nil? ? false : true
  end

  def remove(key)
    returned = nil
    index = get_index(key)
    if @@bucket[index].nil?
      returned = nil
    else
      returned = @@bucket[index][key]
      @@bucket[index] = nil
    end
    returned
  end

  def length
    @@bucket.compact.length
  end

  def clear
    @@bucket = Array.new(16)
  end

  private

  def get_index(key)
    hash_code = hash(key)
    index = hash_code % 16
    index
  end
end
