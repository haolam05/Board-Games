class Item

    CHECK_MARK = "\u2713".force_encoding('utf-8')

    attr_accessor :title, :deadline, :description
    attr_reader :done, :CHECK_MARK

# This method should accept a string and return a boolean indicating if it is valid date of the form 
# YYYY-MM-DD where Y, M, and D are numbers, such as 1912-06-23. The month should be a number from 1 to 12 
# and the day should be a number from 1 to 31. Here are examples of the expected behavior:
# For simplicity, we'll be using well-formed strings to represent our dates.

    def self.valid_date?(date_string)
        year, month, day = date_string.split('-').map(&:to_i)
        return false if date_string.split('-').length != 3 || !(1..12).include?(month) || !(1..31).include?(day)
        true       
    end

# This method should accept a title, deadline, and a description as arguments. 
# These three pieces of data should be stored as instance variables of an Item. 
# If the deadline is not a valid date, raise an error.

    def initialize(title, deadline, description)
        @done = ['', CHECK_MARK]
        @title = title
        @deadline = deadline
        @description = description
        raise 'deadline is invalid' if !Item.valid_date?(@deadline)
    end
    
# Item#deadline=(new_deadline)
# This method should set the item's deadline. However, if the new deadline is not a valid date, 
# then it should raise an error and not change the deadline.
    def deadline=(new_deadline)
        raise 'deadline is invalid' if !Item.valid_date?(new_deadline)
        @deadline = new_deadline 
    end

# This new method should "flip" the current state the item. 
# That is, if the item is done, then change it to not done; if it is not done, then change it to done.

    def toggle
        @done = @done.rotate
    end
end


# Examples:
# p Item.valid_date?('2019-10-25') # true
# p Item.valid_date?('1912-06-23') # true
# p Item.valid_date?('2018-13-20') # false
# p Item.valid_date?('2018-12-32') # false
# p Item.valid_date?('10-25-2019') # false


# item = Item.new('Fix login page', '2019-10-25', 'The page loads too slow.')
# p Item.new(
#     'Buy Cheese',
#     '2019-10-21',
#     'We require American, Swiss, Feta, and Mozzarella cheese for the Happy hour!'
# )
# p Item.new(
#     'Fix checkout page',
#     '10-25-2019',
#     'The font is too small.'
# ) # raises error due to invalid date

# item =  Item.new('Fix login page', '2019-10-25', 'The page loads too slow.')
# p item.title
# p item.deadline
# p item.description
# p item.title = 'hao'
# p item.toggle[0]
# p item.toggle[0]
# p item.toggle[0]