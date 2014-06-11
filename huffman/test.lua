local encode = require 'huffman_encode'
local decode = require 'huffman_decode'

local total, pass = 0, 0

local function run(message, f)
    total = total + 1
    local ok, err = pcall(f)
    if ok then pass = pass + 1 end
    local status = (ok and 'PASSED' or 'FAILED')
    print(('%02d. %s \t: %s'):format(total, message, status))
end
local s_time = os.date("%S")

---[[
run('Test1', function ()
    local str = '\027\024banana\025\026'
    local symbols, enc = encode(str)
    local dec = decode(symbols, enc, #str)
    assert(dec == str)
end)
--]]

print(('-'):rep(80))
local e_time = os.date('%S')
print(('Used %d Second(s)'):format(e_time - s_time))
print(('Total : %02d - Pass: %02d - Failed : %02d\nSuccess: %.2f %%')
    :format(total, pass, total-pass, (pass*100/total)))
