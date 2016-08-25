require 'money' #not using this yet, but should!
require 'csv'
require_relative 'owner'

# Create a Bank module which will contain your Account class and any future bank account logic.
module Bank
  # Create an Account class which should have the following functionality:
  class Account
    @@min_balance = 0 #this is valid across all instances of the class.
    # Should be able to access the current balance of an account at any time.
    attr_reader :account_id, :balance, :owner_id

    # A new account should be created with an ID and an initial balance
    def initialize(account_id, open_date, balance)
      #TODO: does not currently ensure unique number. I will probably have the account_id's created somewhere else outside of the initialize method, so that I can keep track of them and ensure that they're unique. for now, I'll update the initialize method to take in both the account number and the balance.

      @account_id = account_id
      @open_date = open_date
      #TODO: I'm not doing anything with open_date yet, but the data from accounts.csv has it in there, and I may want to initilaize with a default open_date of now.
      puts @@min_balance
      if balance >= @@min_balance #TODO: if user enters a non-number for balance, this fails.
        @balance = balance
      else
        begin
          # A new account cannot be created with balance lower than the minimum - this will raise an ArgumentError
          raise ArgumentError.new("You cannot create an account with a balance below #{ @@min_balance }.")
        # rescue Exception => error
        #   puts error.message
          # The problem with this argument error/rescue block is that if someone tries to create an account with a lower than min balance, and I want to rescue it but not create the account. For now I'll just throw the exception and not rescue, so that I don't end up with accounts with no balance. Another option is to rescue and set the balance to 0 and tell the user to immediately deposit the min balance.
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
      #right now, this just returns those created by the CSV file, but I may want to be able to return all accounts ever created - including those created on their own.
      self.read_accounts_from_file
    end

    def self.find(id)
      #returns an instance of Account where the value of the id field in the CSV matches the passed parameter. note: should use self.all method.
      return self.all[id]
      #TODO: This uses read_accounts_from_file, so if you later call the method to associate_owner and then find, it won't give you the version of the objects with the owners associated.
    end

    # Should have a withdraw method that accepts a single parameter which represents the amount of money that will be withdrawn. This method should return the updated account balance.
    def withdraw(amount, fee = 0)
      # If we set a default fee to be 0, then we can change the fee based on what kind of account/withdrawl is made by the child classes.
      # The withdraw method does not allow the account to go negative - Will output a warning message and return the original un-modified balance
      # Withdraw should also not accept a negative number as the amount.
      total_withdrawl = amount + fee

      if amount > 0 && total_withdrawl + @@min_balance <= @balance
        @balance -= total_withdrawl
      elsif amount < 0
        begin
          raise neg_withdraw = ArgumentError.new("You cannot withdraw a negative amount.")
        rescue
          puts neg_withdraw.message
        end
      elsif total_withdrawl + @@min_balance > @balance
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
          raise ArgumentError.new("Deposits require a positive amount.")
        rescue Exception => error
          puts error.message
        end
      end
      return @balance
    end

    # The Account can be created with an owner, OR you can create a method that will add the owner after the Account has already been created.
    def add_owner(owner_id) # will call this method on an account instance.
        @owner = owner_id
    end

    def self.associate_owner
      #take in csv file of owner to accounts, add an owner to an account using the owner_id.
      all_accounts_with_owners = []
      CSV.read('support/account_owners.csv').each do |match|
        #use the account_id in the account find method to return the account object
        account_id = match[0].to_i
        account = self.find(account_id)
        #use the owner_id in the owner find method to return the owner object
        owner_id = match[1].to_i
        owner = Bank::Owner.find(owner_id)
        #use add_owner to add the owner to the account.
        account.add_owner(owner)
        all_accounts_with_owners << account
      end
      return all_accounts_with_owners
    end
  end
end
