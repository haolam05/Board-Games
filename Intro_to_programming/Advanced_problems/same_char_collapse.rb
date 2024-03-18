# Write a method same_char_collapse that takes in a string and returns a collapsed version of the string. 
# To collapse the string, we repeatedly delete 2 adjacent characters that are the same until there are no 
# such adjacent characters. If there are multiple pairs that can be collapsed, delete the leftmost pair. 
# For example, we take the following steps to collapse "zzzxaaxy": zzzxaaxy -> zxaaxy -> zxxy -> zy

def same_char_collapse(str)
	i = 0
  	while i < str.length
      if str[i] == str[i+1]
        str = str[0...i] + str[i+2..-1]
              							#i = 0				i = 0
          if i == 0						#0 1 2 3 4 5 6 7	0 1 2 3 4 5
            i -= 1	#stay at 0 index	#z z z x a a x y	z x a a x y
          else								
            i -= 2	#go back one index	# i = 2				i = 1
          end							# 0 1 2 3 4 5		0 1 2 3
                                      	# z x a a x y		z x x y
		end
      
      i += 1						
    end
  	 
  	return str
end

puts same_char_collapse("zzzxaaxy")   #=> "zy"
# because zzzxaaxy -> zxaaxy -> zxxy -> zy

puts same_char_collapse("uqrssrqvtt") #=> "uv"
# because uqrssrqvtt -> uqrrqvtt -> uqqvtt -> uvtt -> uv