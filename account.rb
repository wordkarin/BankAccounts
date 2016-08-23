require 'money'

# Create a Bank module which will contain your Account class and any future bank account logic.
module Bank
  # Create an Account class which should have the following functionality:
  class Account
    # Should be able to access the current balance of an account at any time.
    attr_reader :account_id, :balance

    # A new account should be created with an ID and an initial balance
    def initialize(balance = 0)
      @account_id = rand(100000..999999) #TODO: does not currently ensure unique number.
      # A new account cannot be created with initial negative balance - this will raise an ArgumentError (Google this)
      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new("You cannot create an account with a negative balance.")
      end
    end

    # Should have a withdraw method that accepts a single parameter which represents the amount of money that will be withdrawn. This method should return the updated account balance.
    def withdraw(amount)
      # The withdraw method does not allow the account to go negative - Will output a warning message and return the original un-modified balance
      # Withdraw should also not accept a negative number as the amount.
    end

    # Should have a deposit method that accepts a single parameter which represents the amount of money that will be deposited. This method should return the updated account balance.
    def deposit(amount)
      #Deposit should not accept a negative number as the amount.
    end
  end
end
