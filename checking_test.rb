require_relative 'checking_account'

puts "CHECKING TESTS"

puts "CHECKING TEST - $200 New Checking Account"
ch = Bank::CheckingAccount.new(1212,2014,20000)
puts ch.inspect

# Updated withdrawal functionality:
# Each withdrawal 'transaction' incurs a fee of $1 that is taken out of the balance. Returns the updated account balance
puts "CHECKING TEST - Each withdrawl incus a $1 fee."
ch = Bank::CheckingAccount.new(1212, 2014, 20000)
puts ch.inspect
ch.withdraw(2000)
puts ch.inspect

# Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
puts "CHECKING TEST - Withdrawl fails for minimum balance."
ch = Bank::CheckingAccount.new(1212, 2014, 1000)
puts ch.inspect
ch.withdraw(1000)
puts ch.inspect

# #withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
puts "CHECKING TEST - Withdrawl with check. Does not incur $1 fee."
ch = Bank::CheckingAccount.new(1212, 2014, 1000)
puts ch.inspect
ch.withdraw_using_check(1000)
puts ch.inspect

# Allows the account to go into overdraft up to -$10 but not any lower
puts "CHECKING TEST - Withdrawl with check allows min balance of -$10."
ch = Bank::CheckingAccount.new(1212, 2014, 1000)
puts ch.inspect
ch.withdraw_using_check(1100)
puts ch.inspect

puts "CHECKING TEST - Withdrawl with check fails over min balance of -$10."
ch = Bank::CheckingAccount.new(1212, 2014, 1000)
puts ch.inspect
ch.withdraw_using_check(2001)
puts ch.inspect

# The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee
puts "CHECKING TEST - More than 3 checks incurs $2 transaction fee."
ch = Bank::CheckingAccount.new(1212, 2014, 1000)
puts ch.inspect
ch.withdraw_using_check(100)
puts ch.inspect
ch.withdraw_using_check(100)
puts ch.inspect
ch.withdraw_using_check(100)
puts ch.inspect
ch.withdraw_using_check(100)
puts ch.inspect

# #reset_checks: Resets the number of checks used to zero
puts "CHECKING TEST - End of the month, reset num_checks to 0."
ch = Bank::CheckingAccount.new(1212, 2014, 1000)
#uses four checks, 4th one incurs check fee.
4.times do
  ch.withdraw_using_check(100)
  puts ch.inspect
end

ch.reset_checks
#does not incur check fee.
ch.withdraw_using_check(100)
puts ch.inspect

puts "CHECKING TEST - Initialize Failure"
ch = Bank::CheckingAccount.new(1212, 2014, -1)
