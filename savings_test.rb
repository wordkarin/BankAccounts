require_relative 'savings_account'

puts "SAVINGS TEST - $10 open amount, withdrawl fail"
sa = Bank::SavingsAccount.new(1212, 2014, 1000)
puts sprintf("New %s opened with balance of $%0.02f, account number: %i.", sa.class.to_s, sa.balance/100.to_f, sa.account_id)

puts "withdraw $1" #expect this to fail, because minimum balance is 1000, and if we did withdraw 100 + the 200 fee for a withdrawl, the balance would be 970 which is less than 1000.
sa.withdraw(100)
puts sprintf("Account has balance of $%0.02f, account number: %i.", sa.balance/100.to_f, sa.account_id)


puts "SAVINGS TEST - $200 open amount, withdrawl success"
sa = Bank::SavingsAccount.new(1212, 2014, 20000)
puts sprintf("Account has balance of $%0.02f, account number: %i.", sa.balance/100.to_f, sa.account_id)

puts "withdraw $1"
sa.withdraw(100)
puts sprintf("Account has balance of $%0.02f, account number: %i.", sa.balance/100.to_f, sa.account_id)

puts "SAVINGS TEST - $100 open amount, add interest"
sa = Bank::SavingsAccount.new(1212, 2014, 10000)
puts sprintf("Account has balance of $%0.02f, account number: %i.", sa.balance/100.to_f, sa.account_id)

puts "add interest 0.25"
puts sa.add_interest(0.25)
puts sprintf("Account has balance of $%0.02f, account number: %i.", sa.balance/100.to_f, sa.account_id)

puts "SAVINGS TEST - $200 open amount, deposit success"
sa = Bank::SavingsAccount.new(1212, 2014, 20000)
puts sprintf("Account has balance of $%0.02f, account number: %i.", sa.balance/100.to_f, sa.account_id)

puts "deposit $1"
sa.deposit(100)
puts sprintf("Account has balance of $%0.02f, account number: %i.", sa.balance/100.to_f, sa.account_id)

puts "SAVINGS TEST - $9 open amount, Initialize Fail"
sa = Bank::SavingsAccount.new(1212, 2014, 900)
puts sprintf("Account has balance of $%0.02f, account number: %i.", sa.balance/100.to_f, sa.account_id)
