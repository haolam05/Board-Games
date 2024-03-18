# Write a method is_valid_email that takes in a string and returns a boolean 
# indicating whether or not it is a valid email address.

# For simplicity, we'll consider an email valid when it satisfies all of the following:
# - contains exactly one @ symbol
# - contains only lowercase alphabetic letters before the @
# - contains exactly one . after the @

def is_valid_email(str)
	split_arr = str.split('@')
  
  	if split_arr.length != 2 ||
       split_arr[1].split('.').length != 2
      return false
    end
  
  	split_arr[0].each_char do |char|
      if !'abcdefghijklmnopqrstuvwxyz'.include?(char)
        return false
      end
    end
  
	return true
end

# def is_valid_email(str)
# 	split = str.split('@')
#   	if split.length != 2
#       return false
#     end
  	
#   	split[0].each_char do |char|
#       if !'abcdefghijklmnopqrstuvwxyz'.include?(char)
#         return false
#  	  end
#     end
  	
#   	split_2 = split[1].split('.')
#   	if split_2.length != 2	
#   		return false
#     end
  
#   	return true
# end

puts is_valid_email("abc@xy.z")         # => true
puts is_valid_email("jdoe@gmail.com")   # => true
puts is_valid_email("jdoe@g@mail.com")  # => false
puts is_valid_email("jdoe42@gmail.com") # => false
puts is_valid_email("jdoegmail.com")    # => false
puts is_valid_email("az@email")         # => false