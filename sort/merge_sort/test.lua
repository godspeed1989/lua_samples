local merge_sort = require 'merge_sort'

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
local function le(a,b) return a <= b end
local function ge(a,b) return a >= b end
-- Checks if list is sorted
function is_sorted (list, comp)
    comp = comp or le
    for i = 2, #list do
        if not comp(list[i-1],list[i]) then return false end
    end
    return true
end
-- Generates a table of n random values
local function gen (n)
    local t = {}
    for i = 1, n do t[i] = math.random(n) end
    return t
end

math.randomseed(os.time())
run('Empty arrays', function()
    local t = {}
    assert(is_sorted(merge_sort({})))
end)
run('Already sorted array', function()
    local t = {1, 2, 3, 4, 5}
    assert(is_sorted(merge_sort(t)))
end)
run('Sorting a large array (1e4 values)', function()
    local t = gen(1e4)
    assert(is_sorted(merge_sort(t)))
    assert(is_sorted(merge_sort(t, ge), ge))
end)

--]]

print(('-'):rep(80))
e_time = os.date("%S")
print(("Used %d Second(s)"):format(e_time - s_time))
print(('Total : %02d - Pass: %02d - Failed : %02d\nSuccess: %.2f %%')
    :format(total, pass, total-pass, (pass*100/total)))
