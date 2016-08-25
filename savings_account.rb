require_relative 'account'
module Bank
  class SavingsAccount < Account
    @@min_balance = 1000 #this is valid across all instances of this class.

    def initialize(account_id, open_date, amount, interest_rate)
      # The initial balance cannot be less than $10. If it is, this will raise an ArgumentError
      super(account_id, open_date, amount) #passing into Account, the arguments it needs to initialize.
      @interest_rate = interest_rate
    end

    # Updated withdrawal functionality:
    def withdraw(amount)
      super(amount, 200)
      # Each withdrawal 'transaction' incurs a fee of $2 that is taken out of the balance; we're passing 200 ($2) as a parameter to Account's withdraw method, where the default is 0, since every withdrawl from a savings account incurs a $2 fee.
      # The Account class's withdraw method does not allow the account to go below the class's minimum balance - Will output a warning message and return the original un-modified balance. For SavingsAccount's, this is 1000 ($10). 
    end

    # It should include the following new method:
    # #add_interest(rate): Calculate the interest on the balance and add the interest to the balance. Return the interest that was calculated and added to the balance (not the updated balance).
    # Input rate is assumed to be a percentage (i.e. 0.25).
    # The formula for calculating interest is balance * rate/100
    # Example: If the interest rate is 0.25% and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.
  end
end
