-- Run-Length Encoding Compression algorithm  implementation
-- See: https://en.wikipedia.org/wiki/Run-length_encoding

-- encoded string using RLE
function rle_encode(str)
    local prev = str:sub(1, 1)
    local count = 0
    local encoded = ''
    for char in str:gmatch('.') do
        if char == prev then
            count = count + 1
        else
            encoded = encoded .. (count .. prev)
            prev = char
            count = 1
        end
    end
    return encoded .. (count .. prev)
end

-- Decode a RLE string
function rle_decode(str)
    local decoded_str = ''
    for count, match in str:gmatch('(%d+)([^%d]+)') do
        decoded_str = decoded_str .. match:rep(count)
    end
    return decoded_str
end

return {
    encode = rle_encode,
    decode = rle_decode,
}
