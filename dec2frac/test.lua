local dec2frac = require 'dec2frac'

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
local function matches(n, d, nf, df)
    return (n == nf and d == df)
end

run('Testing dec2frac', function()
    assert(matches(       0,        1, dec2frac(      0       )))
    assert(matches(       5,        1, dec2frac(      5       )))
    assert(matches(      11,        2, dec2frac(    5.5       )))
    assert(matches(      23,       10, dec2frac(    2.3       )))
    assert(matches(     945,      167, dec2frac( 5.6587       )))
    assert(matches(     333,      106, dec2frac(math.pi       )))
    assert(matches(80143857, 25510582, dec2frac(math.pi, 1e-15)))
end)
--]]

print(('-'):rep(80))
e_time = os.date("%S")
print(("Used %d Second(s)"):format(e_time - s_time))
print(('Total : %02d - Pass: %02d - Failed : %02d\nSuccess: %.2f %%')
    :format(total, pass, total-pass, (pass*100/total)))
