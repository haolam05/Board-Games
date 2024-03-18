require './list.rb'

class TodoBoard

# For now, a TodoBoard will only need create a single List with the given label and store it as an instance variable.

    def initialize
        @lists = {}
    end

    def get_command
        print "\nPlease enter command: "
        cmd, key, *args = gets.chomp.split(' ')

        case cmd
        when 'mklist'
            @lists[key] = List.new(key)
        when 'ls'
            @lists.values.each { |list| puts ' ' + list.label }
        when 'showall'
            @lists.each_value(&:print)
        when 'mktodo'
            @lists[key].add_item(*args)
        when 'up'
            @lists[key].up(*args.map(&:to_i))
        when 'down'
            @lists[key].down(*args.map(&:to_i))
        when 'swap'
            @lists[key].swap(*args.map(&:to_i))
        when 'sort'
            @lists[key].sort_by_date!
        when 'priority'
            @lists[key].print_priority
        when 'print'
            if args.empty?
                @lists[key].print
            else
                @lists[key].print_full_item(*args[0].to_i)
            end
        when 'toggle'
            @lists[key].toggle_item(*args.map(&:to_i))
        when 'rm'
            @lists[key].remove_item(*args.map(&:to_i))
        when 'purge'
            @lists[key].purge
        when 'quit'
            return false
        else
            puts 'invalid command'
        end

        true
    end

    def run
        until get_command == false
            get_command
        end
    end

end

# todo = TodoBoard.new('groceries')
# todo.get_command