require 'colorize'

class Tile
    attr_reader :val

    def initialize(val)
        @val = val
        @given_val = (val == 0 ? false : true)
    end

    def val=(new_val)
        @val = new_val if !@given_val && in_range?(new_val)
    end

    def reset
        @val = 0
    end

    def color                                    
        @given_val ? val.to_s.colorize(:yellow) : (val == 0 ? ' ' : val.to_s.colorize(:red))
    end
    
private
    def in_range?(val)
        (1..9).include?(val)
    end
end