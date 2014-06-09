-- Move-To-Front Transform implementation
-- See : http://en.wikipedia.org/wiki/Move-to-front_transform

-- find and return the index of a value
local function table_find(t, v)
    for i = 0, 255 do
        if t[i] == v then return i end
    end
end

-- move the value at index to head
local function table_move_to_head(t, i)
    local v = t[i]
    table.remove(t, i)
   table.insert(t, 1, v)
end

local function createDict()
    local Dict = {}
    for i = 0, 255 do
        Dict[i] = string.char(i)
    end
    return Dict
end

-- Encode a string
-- @return : a string of numbers separated with dots
local function mtf_encode(str)
    local dict = createDict()
    local encode_str = ''
    for char in str:gmatch('.') do
        local index = table_find(dict, char)
        assert(index, ('Unknown char %s'):format(char))
        encode_str = encode_str .. index .. '.'
        table_move_to_head(dict, index)
    end
    return (encode_str:gsub('%.$', ''))
end

-- Decodes an mtf transform
-- @return : the decoded string
local function mtf_decode(str)
    local dict = createDict()
    local decode_str = ''
    for value in str:gmatch('%.*(%d+)%.*') do
        local index = tonumber(value)
        assert(index and dict[index], 'Error in decoding')
        decode_str = decode_str .. dict[index]
        table_move_to_head(dict, index)
    end
    return decode_str
end

return {
    encode = mtf_encode,
    decode = mtf_decode,
}
