---[[ Class
Account = {
    balance = 0,
    withdraw = function (self, v)
        self.balance = self.balance - v
    end
}
-- colon add an extra hidden parameter in definition
-- and add an extra argument in a method call
function Account:deposite (v)
    self.balance = self.balance + v
end

function Account:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

Account.deposite(Account, 100)
Account:deposite(250)
Account.withdraw(Account, 100)
Account:withdraw(150)
print(Account.balance)          --> 100

a = Account:new{balance = 0}
a:deposite(200)
print(a.balance)                --> 200

print()
getmetatable(a).__index:deposite(11)
print(Account.balance)          --> 111
print(a.balance)                --> 200

print()
getmetatable(a).__index.deposite(a, 22)
print(Account.balance)          --> 111
print(a.balance)                --> 222
--]]

---[[ Inheritance

SpecialAccount = Account:new()
s = SpecialAccount:new{ limit=1000.00 }

function SpecialAccount:getLimit ()
    return self.limit or 0
end
function SpecialAccount:withdraw (v)
    if v >= self:getLimit() then
        error "excceed limit"
    end
    self.balance = self.balance - v
end

-- SpecialAccount:withdraw(1001)
    --> excceed limit

--]]
