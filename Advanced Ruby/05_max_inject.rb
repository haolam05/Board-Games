# Write a method, max_inject(arr), that accepts any amount of numbers arguments and returns
# the largest number. Solve this using the built-in inject.













p max_inject(1, -4, 0, 7, 5)  # => 7
p max_inject(30, 28, 18)      # => 30

# def max_inject(*nums)
#     nums.max
# end

# def max_inject(*nums)
#     nums.inject do |acc, num|
#         if acc > num
#             acc
#         else
#             num
#         end
#     end
# end