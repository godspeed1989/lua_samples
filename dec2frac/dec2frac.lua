-- Returns a fraction that approximates a given decimal
-- decimal : a decimal to be converted to a fraction
-- acc     : approximation accuracy
-- returns : the numerator and the denominator

local upper_bound = 1e+19
local lower_bound = 1e-19

return function (decimal, acc)
    acc = acc or 1e-4
    local sign, num, denum
    local sign = (decimal < 0) and -1 or 1
    decimal = math.abs(decimal)

    -- integers
    if decimal == math.floor(decimal) then
        num = decimal * sign
        return num, 1
    end
    -- exceed bound
    if decimal > upper_bound then
        num = 9999999999999999999 * sign
        denum = 1
    elseif decimal < lower_bound then
        num = sign
        denum = 9999999999999999999
    end

    local z = decimal
    local predenum = 0
    local sc
    denum = 1

    repeat
        z = 1 / (z - math.floor(z))
        sc = denum
        denum = denum * math.floor(z) + predenum
        predenum = sc
        num = math.floor(decimal * denum)
    until (math.abs(decimal - (num / denum)) < acc or
           z == math.floor(z))

    num = sign * num
    return num, denum
end
