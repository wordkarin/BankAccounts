require_relative 'account'
module Bank
  class CheckingAccount < Account
    #MIN_BALANCE to open account is inherited from the parent class. However, MIN_BALANCE for check withdrawls (OVER_DRAFT, perhaps) is -1000.
    def initialize(account_id, open_date, amount)
      super(account_id, open_date, amount) #Is this needed?
      @checks_used = 0
    end

    def withdraw(amount, fee = 100)
      # Each withdrawal 'transaction' incurs a fee of $1 that is taken out of the balance. Returns the updated account balance
      # Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
      super(amount, fee)
    end

    def withdraw_using_check(amount)
      # #withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
      #does not incur 100 ($1) fee for normal withdrawls
      #allows account to go into overdraft of up to -1000 (-$10).
      #does not work if amount + fee puts account below -1000 (-$10).
      #if checks_used is 3 or greater, a 200 ($2)fee is added.
      if @checks_used < 3
        withdraw(amount, 0)
      else
        withdraw(amount, 200)
      end
      @checks_used += 1 #TODO: a check is still incremented if the withdraw fails. This could be by design or I might want to change it.
    end

    def reset_checks
      # #reset_checks: Resets the number of checks used to zero
      @checks_used = 0
    end
  end
end
