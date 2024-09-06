require_relative 'lib/linked_list'
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
    if @@bucket[index].nil?
      list = LinkedList.new
      list.append(key => value)
    else
      list = @@bucket[index]
      list.append(key => value)
    end
    @@bucket[index] = list
  end

  def get(key)
    index = get_index(key)

    @@bucket[index].nil? ? nil : @@bucket[index].find_entry(key)
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

  def keys
    keys = @@bucket.compact.map { |entry| entry.keys }
    keys.flatten
  end

  def values
    values = @@bucket.compact.map { |entry| entry.values}
    values.flatten
  end

  def entries
    entries = []
    entry_keys = keys
    entry_values = values
    i = 0

    while i < entry_keys.length
      entries.push([entry_keys[i], entry_values[i]])
      i += 1
    end
    entries
  end

  private

  def get_index(key)
    hash_code = hash(key)
    index = hash_code % 16
    index
  end
end
h1 = HashMap.new
h1.set("sara", "yoni")
h1.set("rasa", "kali")
puts h1.get("rasa")