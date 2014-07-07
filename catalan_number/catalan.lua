-- Catalan Number series implementation
-- See: http://en.wikipedia.org/wiki/Catalan_number

-- return the factorial of given number (n!)
local function fact (n)
    return n == 0 and 1 or n*fact(n-1)
end

-- using direct formula
local function catalan_direct (n)
    return fact(2*n)/(fact(n+1)*fact(n))
end

-- using recursive method
local function catalan_recursive (n)
    if n == 0 then return 1 end
    return catalan_recursive(n-1)*(2*(2*n-1)/(n+1))
end

-- memorize a function
local function memorize (f)
    local _cache = {}   -- upvalue
    return function (arg)
        local _result = _cache[arg]
        if _result == nil then _cache[arg] = f(arg) end
        return _cache[arg]
    end
end

local catalan_recursive_memoize =
        memorize(catalan_recursive)

return {
    direct = catalan_direct,
    recursive = catalan_recursive,
    memorized = catalan_recursive_memoize
}
