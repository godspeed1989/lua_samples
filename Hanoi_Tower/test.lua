local hanoi = require 'hanoi'

local total, pass = 0, 0

local function run(message, f)
    total = total + 1
    local ok, err = pcall(f)
    if ok then pass = pass + 1 end
    local status = (ok and 'PASSED' or 'FAILED')
    print(('%02d. %s \t: %s'):format(total, message, status))
end
s_time = os.date("%S")

---[[
run('Hanoi test', function()
    local log = {}
    hanoi(3, 1, 3, 2, log)
    assert(log[1] == '1->3')
    assert(log[2] == '1->2')
    assert(log[3] == '3->2')
    assert(log[4] == '1->3')
    assert(log[5] == '2->1')
    assert(log[6] == '2->3')
    assert(log[7] == '1->3')
end)
--]]

print(('-'):rep(80))
e_time = os.date("%S")
print(("Used %d Second(s)"):format(e_time - s_time))
print(('Total : %02d - Pass: %02d - Failed : %02d\nSuccess: %.2f %%')
    :format(total, pass, total-pass, (pass*100/total)))
