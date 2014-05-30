
function newAccount (initialBalance)
    local self = {balance = initialBalance}
    local withdraw = function (v)
        self.balance = self.balance - v
    end
    local deposit = function (v)
        self.balance = self.balance + v
    end
    local getBalance = function ()
        return self.balance
    end
    return {
        withdraw = withdraw,
        deposit = deposit,
        getBalance = getBalance
    }
end

acc1 = newAccount (100.0)
acc1.withdraw (40.0)
print (acc1.getBalance())
acc2 = newAccount (0)
print (acc2.getBalance())

-- If you do not want to access something inside an object
-- just do not do it.
acc1.balance = 9
