module Bank
  class Owner
    attr_reader :owner_id, :last_name, :first_name, :street_address, :city, :state

    # Create an Owner class which will store information about those who own the Accounts.
    # This should have info like name and address and any other identifying information that an account owner would have.

    def initialize(owner_hash)
      # @owner_id = 10
      # while @owner_ids.include?(@owner_id)
      #   @owner_id += 1
      # end ##I want to check whether the owner_id already belongs to another owner, but I think I need a "Bank" class or learn how to use the modules to keep track? Or use a csv. I'll just leave off owner_id for now.
        @last_name = owner_hash[:last_name]
        @first_name = owner_hash[:first_name]
        @street_address = owner_hash[:street]
        @city = owner_hash[:city]
        @state = owner_hash[:state]
    end
    # Add an owner property to each Account to track information about who owns the account.
    # The Account can be created with an owner, OR you can create a method that will add the owner after the Account has already been created.

    def print_owner_name #take in owner object and print the name
      return @first_name + " " + @last_name
    end
  end
end
