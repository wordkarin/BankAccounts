require_relative 'savings_account'

puts "SAVINGS TEST - $10 open amount, withdrawl fail"
sa = Bank::SavingsAccount.new(1212, 2014, 1000)
puts sa.inspect

puts "withdraw $1" #expect this to fail, because minimum balance is 1000, and if we did withdraw 100 + the 200 fee for a withdrawl, the balance would be 970 which is less than 1000.
sa.withdraw(100)
puts sa.balance

puts "SAVINGS TEST - $200 open amount, withdrawl success"
sa = Bank::SavingsAccount.new(1212, 2014, 20000)
puts sa.inspect

puts "withdraw $1"
sa.withdraw(100)
puts sa.balance

puts "SAVINGS TEST - $100 open amount, add interest"
sa = Bank::SavingsAccount.new(1212, 2014, 10000)
puts sa.inspect

puts "add interest 0.25"
puts sa.add_interest(0.25)
puts sa.balance

puts "SAVINGS TEST - $200 open amount, deposit success"
sa = Bank::SavingsAccount.new(1212, 2014, 20000)
puts sa.inspect

puts "deposit $1"
sa.deposit(100)
puts sa.balance

puts "SAVINGS TEST - $9 open amount, Initialize Fail"
sa = Bank::SavingsAccount.new(1212, 2014, 900)
puts sa.inspect

puts "CHECKING TESTS"
# Updated withdrawal functionality:
# Each withdrawal 'transaction' incurs a fee of $1 that is taken out of the balance. Returns the updated account balance
puts "CHECKING TEST - Each withdrawl incus a $1 fee."

# Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
puts "CHECKING TEST - Withdrawl fails for minimum balance."

# #withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
puts "CHECKING TEST - Withdrawl with check. Does not incur $1 fee."

# Allows the account to go into overdraft up to -$10 but not any lower
puts "CHECKING TEST - Withdrawl with check allows min balance of -$10."

puts "CHECKING TEST - Withdrawl with check fails over min balance of -$10."

# The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee
puts "CHECKING TEST - More than 3 checks incurs $2 transaction fee."

# #reset_checks: Resets the number of checks used to zero
puts "CHECKING TEST - End of the month, reset num_checks to 0."
