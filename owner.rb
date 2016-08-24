require 'csv'

module Bank
  class Owner
    attr_reader :owner_id, :last_name, :first_name, :street_address, :city, :state

    # Create an Owner class which will store information about those who own the Accounts.
    # This should have info like name and address and any other identifying information that an account owner would have.

    def initialize(owner_id, last_name, first_name, street_address, city, state)
      ##I want to check whether the owner_id already belongs to another owner, but I think I need a "Bank" class or learn how to use the modules to keep track? Or use a csv.
      @owner_id = owner_id
      @last_name = last_name
      @first_name = first_name
      @street_address = street_address
      @city = city
      @state = state
    end

    def self.read_from_file
      customers = {}
      CSV.read("support/owners.csv").each do |line|
        #TODO: I feel like I should iterate over this array to pull these things out, but for now I'm going to explicitly set each local variable to each element in the array. 
        owner_id = line[0].to_i  # ID - (Fixnum) a unique identifier for that Owner
        last_name = line[1] # Last Name - (String) the owner's last name
        first_name = line[2] # First Name - (String) the owner's first name
        street_address = line[3] # Street Addess - (String) the owner's street address
        city = line[4] # City - (String) the owner's city
        state = line[5] # State - (String) the owner's state
        customers[owner_id] = self.new(owner_id, last_name, first_name, street_address, city, state)
      end

      return customers
    end

    def self.all
      #returns a collection of Account instances, representing all of the Accounts described in the CSV. See below for the CSV file specifications
      #right now, this just returns those created by the CSV file, but I may want to be able to return all accounts ever created - including those created on their own.
      self.read_from_file
    end

    def self.find(id)
      #returns an instance of Account where the value of the id field in the CSV matches the passed parameter. note: should use self.all method.
      return self.all[id]
    end

    def print_owner_name #take in owner object and print the name
      return @first_name + " " + @last_name
    end
  end
end
