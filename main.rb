require_relative "lib/hash_map"

test = HashMap.new
test.set("apple", "red")
test.set("banana", "yellow")
test.set("carrot", "orange")
test.set("dog", "brown")
test.set("elephant", "gray")
test.set("frog", "green")
test.set("grape", "purple")
test.set("hat", "black")
test.set("ice cream", "white")
test.set("jacket", "blue")
test.set("kite", "pink")
test.set("lion", "golden")
test.set("sow", "mewo")

puts test.get("lion")
puts test.has?("kite")
puts test.get_entries
puts test.length
test.remove("apple")
puts test.length
puts "Keys: \n #{test.keys}"
puts "Values: \n #{test.get_values}"
puts "Entries: \n #{test.get_entries}"
