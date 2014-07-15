
local function identity (n) return n end

local function memorized (f, hash)
    local _cache = {}
    local _hasher = hash or identity
    return function (...)
        local _hashKey = _hasher(...)
        local _result = _cache[_hashKey]
        if not _result then
            _cache[_hashKey] = f(...)
        end
        return _cache[_hashKey]
    end
end

-- Fibonacci function
local function fib (n)
    return n < 2 and n or fib(n-1) + fib(n-2)
end

-- Evaluates the duration of given task
local function time (f, times, ...)
    local start = os.time()
    for i = 1, times do f(...) end
    return (os.time() - start) * 1000
end

print('Fibonacci memorization test: 10 runs for f(30)')
local times = 10

local mfib = memorized(fib)
local fib_time = time(fib, times, 30)
local mfib_time = time(mfib, times, 30)
print(fib_time)
print(mfib_time)
