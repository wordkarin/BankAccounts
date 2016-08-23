require 'money' #not using this yet, but should!

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
        begin
          raise neg_starting_balance = ArgumentError.new("You cannot create an account with a negative balance. Your account was created with a balance of 0. If you meant to create an account with a positive balance, please deposit now.")
        rescue
          puts neg_starting_balance.message
          @balance = 0 #This rescue creates the account object with a zero balance. Maybe want to not create an account if the balance is negative?
        end
      end
    end

    # Should have a withdraw method that accepts a single parameter which represents the amount of money that will be withdrawn. This method should return the updated account balance.
    def withdraw(amount)
      # The withdraw method does not allow the account to go negative - Will output a warning message and return the original un-modified balance
      # Withdraw should also not accept a negative number as the amount.

      if amount > 0 && amount <= @balance
        @balance -= amount
      elsif amount < 0
        begin
          raise neg_withdraw = ArgumentError.new("You cannot withdraw a negative amount.")
        rescue
          puts neg_withdraw.message
        end
      elsif amount > @balance
        begin
          raise amount_exceeds_balance = ArgumentError.new("You do not have enough money to withdraw #{amount}.")
        rescue
          puts amount_exceeds_balance.message
        end
      else
        begin
          raise zero_amount = ArgumentError.new("Withdraws require a non-zero amount.")
        rescue
          puts zero_amount.message
        end
      end

      return @balance
    end

    # Should have a deposit method that accepts a single parameter which represents the amount of money that will be deposited. This method should return the updated account balance.
    def deposit(amount)
      #Deposit should not accept a negative number as the amount.
      if amount > 0
        @balance += amount
      else
        begin
          raise pos_deposit = ArgumentError.new("Deposits require a positive amount.")
        rescue
          puts pos_deposit.message
        end
      end
      return @balance
    end
  end
end
