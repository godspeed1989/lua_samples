local rle = require 'rle'

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
run('Encoding string tests', function()
    assert(rle.encode('W')                                                                   == '1W')
    assert(rle.encode('WWWW')                                                                == '4W')
    assert(rle.encode('wwwwwiiiikkkkkkkiiippppppeeeeeddddiia')                               == '5w4i7k3i6p5e4d2i1a')
    assert(rle.encode('BBBBBBBBBBBBNBBBBBBBBBBBBNNNBBBBBBBBBBBBBBBBBBBBBBBBNBBBBBBBBBBBBBB') == '12B1N12B3N24B1N14B')
    assert(rle.encode('WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWBWWWWWWWWWWWWWW') == '12W1B12W3B24W1B14W')
end)

run('Decoding string tests', function()
    assert(rle.decode(rle.encode('WW'))                                                                  == 'WW')
    assert(rle.decode(rle.encode('WWWW'))                                                                == 'WWWW')
    assert(rle.decode(rle.encode('wwwwwiiiikkkkkkkiiippppppeeeeeddddiia'))                               == 'wwwwwiiiikkkkkkkiiippppppeeeeeddddiia')
    assert(rle.decode(rle.encode('BBBBBBBBBBBBNBBBBBBBBBBBBNNNBBBBBBBBBBBBBBBBBBBBBBBBNBBBBBBBBBBBBBB')) == 'BBBBBBBBBBBBNBBBBBBBBBBBBNNNBBBBBBBBBBBBBBBBBBBBBBBBNBBBBBBBBBBBBBB')
    assert(rle.decode(rle.encode('WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWBWWWWWWWWWWWWWW')) == 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWBWWWWWWWWWWWWWW')
end)
--]]

print(('-'):rep(80))
e_time = os.date("%S")
print(("Used %d Second(s)"):format(e_time - s_time))
print(('Total : %02d - Pass: %02d - Failed : %02d\nSuccess: %.2f %%')
    :format(total, pass, total-pass, (pass*100/total)))
