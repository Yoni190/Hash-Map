require_relative 'lib/linked_list'
class HashMap
  @@bucket = Array.new(16)
  
  def gb
    @@bucket
  end

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
    if @@bucket[index].nil?
      false
    elsif get(key) != nil
      true
    end
  end

  def remove(key)
    returned = nil
    index = get_index(key)
    value = get(key)
    if @@bucket[index].nil? || value.nil?
      returned = nil
    else
      entry_index = @@bucket[index].find(key => value)
      @@bucket[index].remove_at(entry_index)
      returned = value
    end
    returned
  end

  def length
    length = 0
    @@bucket.compact.each { |entry| length += entry.size}
    length
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
    entries = @@bucket.compact.map { |entry| entry.get_values}
    entries.flatten
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
h1.set("suii", "cr7")
h1.set("iusis", "mes")
puts h1.gb
p h1.entries