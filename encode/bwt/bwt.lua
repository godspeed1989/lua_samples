-- Burrows-Wheeler Transform algorithm implementation
-- See: http://en.wikipedia.org/wiki/Burrows%E2%80%93Wheeler_transform#Sample_implementation

-- encode string using Burrows-Wheeler transform
local function burrows_wheeler_transform(str)
    local t = {str}
    local len = #str
    -- builds a table of all possible rotations
    for i = len, 2, -1 do
        table.insert(t, str:sub(i, len) .. str:sub(1, i-1))
    end
    -- sorts all rotations in alphabetical order
    table.sort(t)

    local pos = 0
    local encoded = ''
    -- retrieves the last column and the word index
    for k, rotation in ipairs(t) do
        if rotation == str then pos = k end
        encoded = encoded .. rotation:sub(#rotation, #rotation)
    end
    return encoded, pos
end

-- decode a Burrows-Wheeler transform string
local function burrows_wheeler_decode(transform, pos)
    local len = #transform

    local t = {}
    -- Builds the table of permutations
    for k = 1, len do
        for i = 1, len do
            local char = transform:sub(i, i)
            if t[i] == nil then
                t[i] = char
            else
                t[i] = char .. t[i]
            end
        end
        table.sort(t)
    end

    -- Return the line ending with the EOL marker
    return t[pos]
end

return {
    encode = burrows_wheeler_transform,
    decode = burrows_wheeler_decode,
}
