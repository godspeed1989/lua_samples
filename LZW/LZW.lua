local dict_size = 256

local function lzw_encode(str)
    if not type(str)=="string" then
        return nil, "Can only encode string"
    end
    -- Build dictionary
    local dict = {}
    for i = 0, dict_size-1 do
        dict[string.char(i)] = i
    end
    -- Encode
    local result = {}
    local d_size = dict_size
    local w = ""
    for char in str:gmatch(".") do
        local wc = w .. char
        if dict[wc] then
            -- Finds the longest string matching the input
            w = wc
        else
            -- Add match to dictionary
            table.insert(result, dict[w])
            dict[wc] = d_size
            d_size = d_size + 1
            w = char
        end
    end
    if w ~= "" then
        table.insert(result, dict[w])
    end
    return result
end

local function lzw_decode(str)
    -- Build dictionary
    local dict = {}
    for i = 0, dict_size-1 do
        dict[i] = string.char(i)
    end
    -- Decode
    local d_size = dict_size
    local w = string.char(str[1])
    local result = w
    for i = 2, #str do
        local idx = str[i]
        local entry = ""
        if dict[idx] then
            entry = dict[idx]
        elseif idx == d_size then
            entry = w .. w:sub(1,1)
        else
            error("No match found, decoding error")
        end
        result = result .. entry
        dict[d_size] = w .. entry:sub(1,1)
        d_size = d_size + 1
        w = entry
    end
    return result
end

return {
    encode = lzw_encode,
    decode = lzw_decode,
}
