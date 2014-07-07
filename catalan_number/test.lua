local catalan = require 'catalan'

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
run('10 first Catalan Numbers using direct formula', function()
    assert(catalan.direct(0)  == 1)
    assert(catalan.direct(1)  == 1)
    assert(catalan.direct(2)  == 2)
    assert(catalan.direct(3)  == 5)
    assert(catalan.direct(4)  == 14)
    assert(catalan.direct(5)  == 42)
    assert(catalan.direct(6)  == 132)
    assert(catalan.direct(7)  == 429)
    assert(catalan.direct(8)  == 1430)
    assert(catalan.direct(9)  == 4862)
    assert(catalan.direct(10) == 16796)
end)

run('10 first Catalan Numbers using recursive formula', function()
    assert(catalan.recursive(0)  == 1)
    assert(catalan.recursive(1)  == 1)
    assert(catalan.recursive(2)  == 2)
    assert(catalan.recursive(3)  == 5)
    assert(catalan.recursive(4)  == 14)
    assert(catalan.recursive(5)  == 42)
    assert(catalan.recursive(6)  == 132)
    assert(catalan.recursive(7)  == 429)
    assert(catalan.recursive(8)  == 1430)
    assert(catalan.recursive(9)  == 4862)
    assert(catalan.recursive(10) == 16796)
end)

run('10 first Catalan Numbers using recursive formula', function()
    assert(catalan.memorized(0)  == 1)
    assert(catalan.memorized(1)  == 1)
    assert(catalan.memorized(2)  == 2)
    assert(catalan.memorized(3)  == 5)
    assert(catalan.memorized(4)  == 14)
    assert(catalan.memorized(5)  == 42)
    assert(catalan.memorized(6)  == 132)
    assert(catalan.memorized(7)  == 429)
    assert(catalan.memorized(8)  == 1430)
    assert(catalan.memorized(9)  == 4862)
    assert(catalan.memorized(10) == 16796)
end)

--]]

print(('-'):rep(80))
e_time = os.date("%S")
print(("Used %d Second(s)"):format(e_time - s_time))
print(('Total : %02d - Pass: %02d - Failed : %02d\nSuccess: %.2f %%')
    :format(total, pass, total-pass, (pass*100/total)))
