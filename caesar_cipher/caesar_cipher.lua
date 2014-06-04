-- Caesar ciphering algorithm implementation
-- See: http://en.wikipedia.org/wiki/Caesar_cipher

local function ascii_base(s)
--    return s:lower() == s and 'a' or 'A'
    return (s:lower() == s) and
        ('a'):byte() or ('A'):byte()
end

-- str      : a string to be ciphered
-- key      : the ciphering key (a number)
-- returns  : the ciphered string
-- :letter in the text is replaced by a letter
-- :some fixed number of positions down the alphabet
local function caesar_cipher(str, key)
    return (str:gsub('%a', function(s)
                local base = ascii_base(s)
                return string.char(base + (s:byte() - base + key) % 26)
            end))
end

local function caesar_decipher(str, key)
    return caesar_cipher(str, -key)
end

return {
    cipher   = caesar_cipher,
    decipher = caesar_decipher,
}
