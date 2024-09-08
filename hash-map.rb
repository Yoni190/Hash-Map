require_relative 'lib/linked_list'
class HashMap

  attr_accessor :capacity, :load_factor, :bucket
  def initialize
    self.capacity = 16
    self.load_factor = 0.75
    self.bucket = Array.new(self.capacity)
  end
  
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    index = get_index(key)
    if self.capacity * self.load_factor <= length
      temp = self.bucket
      self.capacity *= 2
      self.bucket = Array.new(self.capacity).slice!(0..temp.length-1)
      self.bucket = temp + bucket
    end
    if self.bucket[index].nil?
      list = LinkedList.new
      list.append(key => value)
    else
      list = self.bucket[index]
      if get_keys.include?(key)
        old_value = get(key)
        list.replace({key => old_value}, {key => value})
      else
        list.append(key => value)
      end
    end
    self.bucket[index] = list
  end

  def get(key)
    index = get_index(key)

    self.bucket[index].nil? ? nil : self.bucket[index].find_entry(key)
  end

  def has?(key)
    index = get_index(key)
    self.bucket[index].nil? ? false : true
    if self.bucket[index].nil?
      false
    elsif get(key) != nil
      true
    end
  end

  def remove(key)
    returned = nil
    index = get_index(key)
    value = get(key)
    if self.bucket[index].nil? || value.nil?
      returned = nil
    else
      entry_index = self.bucket[index].find(key => value)
      self.bucket[index].remove_at(entry_index)
      returned = value
    end
    returned
  end

  def length
    length = 0
    self.bucket.compact.each { |entry| length += entry.size}
    length
  end

  def clear
    self.bucket = Array.new(16)
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
    entries = self.bucket.compact.map { |entry| entry.get_values}
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
test.set("sow", "mewo")