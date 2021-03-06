local mtf = require 'mtf'

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
local function same(t1, t2)
    if #t1 ~= #t2 then return false end
    for r, row in ipairs(t1) do
        for v, value in ipairs(row) do
            if t2[r][v] ~= value then return false end
        end
    end
    return true
end

run('Encoding string tests', function()
    assert(mtf.encode('banana') == '98.98.110.2.2.2')
    assert(mtf.encode('1578rr') == '49.53.55.56.114.1')
    assert(mtf.encode('')       == '')
    assert(mtf.encode('     ')  == '32.1.1.1.1')
    assert(mtf.encode('mtf')    == '109.116.104')
    assert(mtf.encode('M.T.F.') == '77.47.84.2.72.2')
end)

run('Decoding string tests', function()
    assert(mtf.decode(mtf.encode('banana')) == 'banana')
    assert(mtf.decode(mtf.encode('1578rr')) == '1578rr')
    assert(mtf.decode(mtf.encode('     '))  == '     ')
    assert(mtf.decode(mtf.encode(''))       == '')
    assert(mtf.decode(mtf.encode('mtf'))    == 'mtf')
    assert(mtf.decode(mtf.encode('M.T.F.'))    == 'M.T.F.')
end)
--]]

print(('-'):rep(80))
e_time = os.date("%S")
print(("Used %d Second(s)"):format(e_time - s_time))
print(('Total : %02d - Pass: %02d - Failed : %02d\nSuccess: %.2f %%')
    :format(total, pass, total-pass, (pass*100/total)))
