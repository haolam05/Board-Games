# Write a method hash_to_pairs that takes in a hash and returns a 2D array 
# representing each key-value pair of the hash.

def hash_to_pairs(hash)
	arr = []
  	hash.each { |k, v| arr << [k, v] }
  	return arr
end

# def hash_to_pairs(hash)
#   	arr = []
  
#   	hash.each do |k, v|
#       arr << [k, v]
#     end
  
# 	return arr
# end


print hash_to_pairs({"name"=>"skateboard", "wheels"=>4, "weight"=>"7.5 lbs"}) #=> [["name", "skateboard"], ["wheels", 4], ["weight", "7.5 lbs"]]
puts


print hash_to_pairs({"kingdom"=>"animalia", "genus"=>"canis", "breed"=>"German Shepherd"}) #=> [["kingdom", "animalia"], ["genus", "canis"], ["breed", "German Shepherd"]]
puts