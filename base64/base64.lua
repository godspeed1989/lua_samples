band    = bit32.band
lshift  = bit32.lshift
rshift  = bit32.rshift

local index_table = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function byte_to_binary (byte)
    local bin_bits = ''
    for i = 7, 0, -1 do
        local bit = band(rshift(byte, i), 1)
        if bit == 1 then
            bin_bits = bin_bits .. 1
        else
            bin_bits = bin_bits .. 0
        end
    end
    return bin_bits
end

function base64_encode (to_encode)
    -- converter to bit stream
    local bit_pattern = ''
    for i = 1, #to_encode do
        bit_pattern = bit_pattern .. byte_to_binary(string.byte(string.sub(to_encode, i, i)))
    end
    -- Check the number of bytes. If it's not evenly divisible by three,
    -- zero-pad the ending & append on the correct number of `=`s.
    local trailing = ''
    if #bit_pattern % 3 == 2 then
        trailing = '=='
        bit_pattern = bit_pattern .. '0000000000000000'
    elseif #bit_pattern % 3 == 1 then
        trailing = '='
        bit_pattern = bit_pattern .. '00000000'
    end
    -- encode, every 6 bits
    local encoded = ''
    for i = 1, #bit_pattern, 6 do
        local byte = string.sub(bit_pattern, i, i+5)
        local offset = tonumber(byte, 2)
        encoded = encoded .. string.sub(index_table, offset+1, offset+1)
    end

    return string.sub(encoded, 1, -1 - #trailing) .. trailing
end

function base64_decode (to_decode)
    local unpadded = to_decode:gsub("=", "")
    -- decode to bit stream
    local bit_pattern = ''
    for i = 1, #unpadded do
        local char = string.sub(unpadded, i, i)
        local offset, _ = string.find(index_table, char)
        if offset == nil then
            error("Invalid character '" .. char .. "' found.")
        end
        bit_pattern = bit_pattern .. string.sub(byte_to_binary(offset-1), 3)
    end
    -- to 8 bits byte
    local decoded = ''
    for i = 1, #bit_pattern, 8 do
        local byte = string.sub(bit_pattern, i, i+7)
        decoded = decoded .. string.char(tonumber(byte,2))
    end
    -- deal with padding
    local padding_length = to_decode:len()-unpadded:len()
    if padding_length == 1 or padding_length == 2 then
        decoded = decoded:sub(1, -2)
    end

    return decoded
end

return {
    encode = base64_encode,
    decode = base64_decode
}
