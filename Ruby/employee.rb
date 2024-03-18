require 'byebug'
class Employee
    attr_reader :name, :title, :salary, :boss

    def initialize(name, title, salary, boss = nil)
        @name, @title, @salary, @boss = name, title, salary, boss
        boss.add_employee(self) if !boss.nil?
    end

    def bonus(multiplier)
        salary * multiplier
    end
end

class Manager < Employee
    attr_reader :employees

    def initialize(name, title, salary, boss = nil)
        super
        @employees = []
    end
    
    def bonus(multiplier)
        employees.map { |employee| employee.salary }.sum * multiplier
    end

    def add_employee(employee)
        @employees << employee
        boss.add_employee(employee) unless boss.nil?
    end
end

ned = Manager.new('Ned', 'Founder', 1000000)
darren = Manager.new('Darren', 'TA Manager', 78000, ned)
shawna = Employee.new('Shawna', 'TA', 12000, darren)
david = Employee.new('David', 'TA', 10000, darren)

puts "Ned employees: \n\t#{ned.employees.map(&:name).join(' ')}"
puts "Darren employees: \n\t#{darren.employees.map(&:name).join(' ')}"

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)