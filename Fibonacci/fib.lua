-- Fibonacci series implementation
-- See: http://en.wikipedia.org/wiki/Fibonacci_number
-- F(0) is undefined
-- F(1) = 1
-- F(2) = 1
-- F(n) = F(n-1) + F(n-2)

-- memorize a function
local function memorize (f)
    local _cache = {}   -- upvalue
    return function (arg)
        local _result = _cache[arg]
        if _result == nil then _cache[arg] = f(arg) end
        return _cache[arg]
    end
end

-- Recursive evaluation of Fibonacci series
local function fib (n)
    if n == 1 or n == 2 then return 1 end
    return fib(n-1) + fib(n-2)
end

-- Iterator for Fibonacci series
local function fib_iter (n)
    assert(n > 0, 'Expected n >= 0!')
    return coroutine.wrap(function()
        local a, b, k = 0, 1, 0
        while k < n do
            a, b = b, a+b
            k = k + 1
            coroutine.yield(k, a)
        end
    end)
end

return {
    fib = memorize(fib),
    fib_iter = fib_iter
}
