require_relative 'lib/linked_list'
class HashMap
  @capacity = 16
  @load_factor = 0.75
  @@bucket = Array.new(@capacity)
  

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
      if get_keys.include?(key)
        old_value = get(key)
        list.replace({key => old_value}, {key => value})
      else
        list.append(key => value)
      end
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

  def get_keys
    entries = get_entries
    keys = entries.map { |entry| entry.keys}
    keys.flatten
  end

  def get_values
    entries = get_entries
    values = entries.map { |entry| entry.values}
    values.flatten
  end

  def get_entries
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
test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
puts test.get_entries
test.set('apple', 'blue')
test.set('lion', 'suiii')
puts test.get_entries