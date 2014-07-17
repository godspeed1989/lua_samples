local base64 = require 'base64'

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
run('Encode test', function()
    assert(base64.encode('Man') == 'TWFu')
    assert(base64.encode('leasure.') == 'bGVhc3VyZS4=')
    assert(base64.encode('pleasure.') == 'cGxlYXN1cmUu')
    assert(base64.encode('easure.') == 'ZWFzdXJlLg==')
    assert(base64.encode('sure.') == 'c3VyZS4=')
end)

run('Encode test', function()
    local str = 'Man'
    assert(base64.decode(base64.encode(str)) == str)
    local str = 'easure'
    assert(base64.decode(base64.encode(str)) == str)
    local str = 'pleasure'
    assert(base64.decode(base64.encode(str)) == str)
end)
--]]

print(('-'):rep(80))
e_time = os.date("%S")
print(("Used %d Second(s)"):format(e_time - s_time))
print(('Total : %02d - Pass: %02d - Failed : %02d\nSuccess: %.2f %%')
    :format(total, pass, total-pass, (pass*100/total)))
