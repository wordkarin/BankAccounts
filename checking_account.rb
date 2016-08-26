require_relative 'account'

module Bank
  class CheckingAccount < Account
    alias_method :account_withdraw, :withdraw #allows me to access the withdraw method from Account instead of CheckingAccount, by calling it :account_withdraw.

    MIN_OPEN = 0 #probably don't need this, it's the same as the parent class
    MIN_BALANCE = 0 #probably don't need this, it's the same as the parent class
    OVERDRAFT = -1000

    def initialize(account_id, open_date, amount)
      super(account_id, open_date, amount)
      @checks_used = 0
    end

    def withdraw(amount)
      # Each withdrawal 'transaction' incurs a fee of $1 that is taken out of the balance. Returns the updated account balance
      # Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
      super(amount, 100)
    end

    def withdraw_using_check(amount)
      # #withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
      #does not incur 100 ($1) fee for normal withdrawls
      #allows account to go into overdraft of up to -1000 (-$10).
      #does not work if amount + fee puts account below -1000 (-$10).
      #if checks_used is 3 or greater, a 200 ($2)fee is added.
      if @checks_used < 3
        account_withdraw(amount, 0, self.class::OVERDRAFT)
      else
        account_withdraw(amount, 200, self.class::OVERDRAFT)
      end
      @checks_used += 1 #TODO: a check is still incremented if the withdraw fails. This could be by design or I might want to change it. I'm leaving for now. 
    end

    def reset_checks
      # #reset_checks: Resets the number of checks used to zero
      @checks_used = 0
    end
  end
end
