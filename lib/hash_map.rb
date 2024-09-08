require_relative "linked_list"
class HashMap
  def initialize
    @capacity = 16
    @load_factor = 0.75
    @bucket = Array.new(@capacity)
  end

  def set(key, value)
    index = get_index(key)
    if @capacity * @load_factor <= length
      temp = @bucket
      @capacity *= 2
      @bucket = Array.new(@capacity).slice!(0..temp.length - 1)
      @bucket = temp + @bucket
    end
    if @bucket[index].nil?
      list = LinkedList.new
      list.append(key => value)
    else
      list = @bucket[index]
      if keys.include?(key)
        old_value = get(key)
        list.replace({ key => old_value }, { key => value })
      else
        list.append(key => value)
      end
    end
    @bucket[index] = list
  end

  def get(key)
    index = get_index(key)

    @bucket[index]&.find_entry(key)
  end

  def has?(key)
    index = get_index(key)
    @bucket[index].nil?
    if @bucket[index].nil?
      false
    elsif !get(key).nil?
      true
    end
  end

  def remove(key)
    returned = nil
    index = get_index(key)
    value = get(key)
    if @bucket[index].nil? || value.nil?
      returned = nil
    else
      entry_index = @bucket[index].find(key => value)
      @bucket[index].remove_at(entry_index)
      returned = value
    end
    returned
  end

  def length
    length = 0
    @bucket.compact.each { |entry| length += entry.size }
    length
  end

  def clear
    @bucket = Array.new(16)
  end

  def keys
    entries = get_entries
    keys = entries.map(&:keys)
    keys.flatten
  end

  def get_values
    entries = get_entries
    values = entries.map(&:values)
    values.flatten
  end

  def get_entries
    entries = @bucket.compact.map(&:get_values)
    entries.flatten
  end

  private

  def get_index(key)
    hash_code = hash(key)
    hash_code % 16
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }
    hash_code
  end
end
