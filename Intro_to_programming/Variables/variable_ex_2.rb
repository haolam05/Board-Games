# Variables Exercise 2
# Predict what the following puts lines with question marks will print out. 
# Write down your predictions as comments. Check your work by running the code 
# and comparing the output to your prediction.

sentence = "There is no spoon"
puts "---1:"
puts sentence + "?"   # "There is no spoon?"

puts "---2:"
puts sentence         # "There is no spoon"

sentence += "."
puts "---3:"
puts sentence         # "There is no spoon."

num = 6 / 2
puts "---4:"
puts num              # "3"

puts "---5:"
puts sentence[num]    # "r"