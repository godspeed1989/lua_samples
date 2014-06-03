local knapsack = require 'knapsack'

local total, pass = 0, 0

local function run(message, f)
    total = total + 1
    local ok, err = pcall(f)
    if ok then pass = pass + 1 end
    local status = (ok and 'PASSED' or 'FAILED')
    print(('%02d. %s \t: %s'):format(total, message, status))
end

---[[
run('Testing 0/1 knapsack', function()
    local items = {
        {name = 'Apple', w = 5, p = 10},
        {name = 'Orange', w = 4, p = 40},
        {name = 'Salt', w = 6, p = 30},
        {name = 'Pepper', w = 3, p = 50},
    }
    local capacity= 10
    local sack, profit = knapsack(items, capacity)
    assert(#sack == 2)
    local s1, s2 = sack[1], sack[2]
    assert(s1.name == 'Pepper' and s1.w == 3 and s1.p == 50)
    assert(s2.name == 'Orange' and s2.w == 4 and s2.p == 40)
    assert(profit == 90)
end)
--]]

print(('-'):rep(80))
print(('Total : %02d - Pass: %02d - Failed : %02d\nSuccess: %.2f %%')
    :format(total, pass, total-pass, (pass*100/total)))
