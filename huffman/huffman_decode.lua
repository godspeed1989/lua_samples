-- get one bit from str at bit_index
local function getBit(str, bit_index)
    local byte_index = 1 + math.floor(bit_index / 8)
    bit_index = bit_index % 8
    local byte = string.byte(str, byte_index)
    byte = bit32.rshift(byte, bit_index)
    return bit32.band(byte, 1)
end

local function Huffman_Decode(symbols_code, compressed, uncompressed_size)
    if not type(compressed)=="string" then
        return nil, 'Can only encode strings'
    end
    if #compressed == 0 then
        return ''
    end

    -- build bcodes table using bcode as index
    bcodes_tbl = {}
    for symbol, leaf in pairs(symbols_code) do
        bcodes_tbl[leaf.bcode] = {
            blength = leaf.blength,
            symbol = symbol
        }
    end

    local i = 0
    local bit_index = 0
    local uncompressed = {}
    -- decode using bcodes table
    while i < uncompressed_size do
        local bcode = 0
        local blength = 0
        -- add one bit each time
        repeat
            if blength > 32 then
                error('too long code-words')
            end
            if bit_index >= #compressed * 8 then
                error('not data to decompress')
            end
            local add = bit32.lshift(getBit(compressed, bit_index), blength)
            bcode = bcode + add
            blength = blength + 1
            bit_index = bit_index + 1
        until bcodes_tbl[bcode] and bcodes_tbl[bcode].blength == blength
        i = i + 1
        uncompressed[i] = string.char(bcodes_tbl[bcode].symbol)
    end

    -- convert to string
    return table.concat(uncompressed, nil)
end

return Huffman_Decode
