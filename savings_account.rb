require_relative 'account'
module Bank
  class SavingsAccount < Account
    MIN_OPEN = 1000
    MIN_BALANCE = MIN_OPEN #this is valid across all instances of this class.

    def initialize(account_id, open_date, amount)
      # The initial balance cannot be less than $10. If it is, this will raise an ArgumentError
      super(account_id, open_date, amount) #passing into Account, the arguments it needs to initialize.
    end

    # Updated withdrawal functionality:
    def withdraw(amount)
      # Each withdrawal 'transaction' incurs a fee of $2 that is taken out of the balance; we're passing 200 ($2) as a parameter to Account's withdraw method, where the default is 0, since every withdrawl from a savings account incurs a $2 fee.
      # The Account class's withdraw method does not allow the account to go below the class's minimum balance - Will output a warning message and return the original un-modified balance. For SavingsAccount's, the minimum is 1000 ($10).
      super(amount, 200)
    end

    # It should include the following new method:
    def add_interest(rate)
      #add_interest(rate): Calculate the interest on the balance and add the interest to the balance. Return the interest that was calculated and added to the balance (not the updated balance).
      # Input rate is assumed to be a percentage (i.e. 0.25).

      interest = (@balance * rate/100).to_i #want to ensure whole cent values.
      @balance = @balance + interest

      return interest
    end
  end
end
