require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(other_startup)
        return false if self.funding < other_startup.funding
        true
    end

    def hire(name, title)
        raise if !valid_title?(title)
        @employees << Employee.new(name, title)
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = salaries[employee.title]
        raise if self.funding < salary
        employee.pay(salary)
        @funding -= salary
    end

    def payday
        @employees.each { |employee| pay_employee(employee) }
    end

    def average_salary
        sum = 0
        @employees.each { |employee| sum += @salaries[employee.title] }
        sum / self.size
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(other_startup)
        @funding += other_startup.funding
        other_startup.salaries.each { |title, salary| @salaries[title] = salary if !valid_title?(title) }
        @employees += other_startup.employees
        other_startup.close
    end
end
