require 'money' #not using this yet, but should!
require_relative 'owner'
require 'csv'

# Create a Bank module which will contain your Account class and any future bank account logic.
module Bank
  # Create an Account class which should have the following functionality:
  class Account
    # Should be able to access the current balance of an account at any time.
    attr_reader :account_id, :balance, :owner_id

    # A new account should be created with an ID and an initial balance
    def initialize(account_id, open_date, balance = 0)
      #TODO: does not currently ensure unique number. I will probably have the account_id's created somewhere else outside of the initialize method, so that I can keep track of them and ensure that they're unique. for now, I'll update the initialize method to take in both the account number and the balance.

      @account_id = account_id
      @open_date = open_date
      #TODO: I'm not doing anything with open_date yet, but the data from accounts.csv has it in there, and I may want to initilaize with a default open_date of now.

      if balance >= 0 #TODO: if user enters a non-number for balance, this fails.
        @balance = balance
      else
        begin
          # A new account cannot be created with initial negative balance - this will raise an ArgumentError
          raise neg_starting_balance = ArgumentError.new("You cannot create an account with a negative balance. Your account was created with a balance of 0. If you meant to create an account with a positive balance, please make a deposit now.")
        rescue
          puts neg_starting_balance.message
          @balance = 0 #This rescue creates the account object with a zero balance. Maybe want to not create an account if the balance is negative?
        end
      end


    end

    #takes a CSV file of format account id, balance in cents, date opened; outputs an array of the account objects created from that file
    def self.read_accounts_from_file
      accounts = {}

      CSV.read("support/accounts.csv").each do |line|
      account_id = line[0].to_i
      balance = line[1].to_i
      open_date = line[2]
      accounts[account_id] = self.new(account_id, open_date, balance)
      end

      return accounts
    end

    def self.all
      #returns a collection of Account instances, representing all of the Accounts described in the CSV. See below for the CSV file specifications
      self.read_accounts_from_file
    end

    def self.find(id)
      #returns an instance of Account where the value of the id field in the CSV matches the passed parameter. note: should use self.all method.
      all_accounts = self.all
      return all_accounts[id]
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

    # The Account can be created with an owner, OR you can create a method that will add the owner after the Account has already been created.
    def add_owner(owner)
        @owner = owner #do I need to figure out how to associate this with the current instance of the account? (would call this method on an account instance.)
    end
  end
end
