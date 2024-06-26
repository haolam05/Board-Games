# PHASE 2
class CoffeeError < StandardError
  def message 
    "Coffee received. You can try again!"
  end
end

class NotAFruitError < StandardError
  def message
    "No such fruit. You tricked me!!!!"
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit.downcase == 'coffee'
    raise CoffeeError 
  else
    raise NotAFruitError
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  
  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp    
    reaction(maybe_fruit) 
  rescue CoffeeError => e
    puts e.message
    retry
  rescue NotAFruitError => e
    puts e.message
  end
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new "'name' can NOT be empty!" if name.empty?
    raise ArgumentError.new "We are NOT best friend yet!!. 'yrs_known' must >= 5. Best friend takes time." if yrs_known < 5
    raise ArgumentError.new "'fav_pastime' can NOT be empty!" if fav_pastime.empty?
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known} years. Let's be friends for another #{1000 * @yrs_known} years."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


