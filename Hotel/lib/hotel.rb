require_relative 'room'
class Hotel
    def initialize(name, hash)
        @name = name
        @rooms = {}
        hash.each { |room_name, capacity| @rooms[room_name] = Room.new(capacity) }
    end

    def name
        @name.split.map(&:capitalize).join(' ')
    end

    def rooms
        @rooms
    end

    def room_exists?(room_name)
        @rooms.has_key?(room_name)
    end

    def check_in(guest, room_name)
        if !room_exists?(room_name)
            puts 'sorry, room does not exist'
        else
            if @rooms[room_name].add_occupant(guest)
                puts 'check in successful'
            else
                puts 'sorry, room is full'
            end
        end
    end

    def has_vacancy?
        @rooms.values.any? { |room_instance| !room_instance.full? }
    end

    def list_rooms
        @rooms.each { |room_name, room_instance| puts "#{room_name} #{room_instance.available_space}" }
    end
end
