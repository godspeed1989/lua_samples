-- generate code top-down for Huffman tree
local function genCode(tree_node, bcode, len)
    -- left = "0", right = "1"
    tree_node.bcode = bcode
    tree_node.blength = len
    if tree_node.left then
        genCode(tree_node.left, bcode, len+1)
    end
    if tree_node.right then
        _bcode = bit32.bor(bcode, bit32.lshift(1, len))
        genCode(tree_node.right, _bcode, len+1)
    end
end

-- Huffman encode a string
-- @return1 : symbol encode table { symbol, {bcode, blength} }
-- @return2 : encoded string
function Huffman_Encode(uncompressed)
    if not type(uncompressed)=='string' then
        return nil, 'Can only encode strings'
    end
    if #uncompressed == 0 then
        return ''
    end

    -- make histogram
    local hist = {}
    for i = 1, #uncompressed do
        local c = string.byte(uncompressed, i)
        hist[c] = (hist[c] or 0) + 1
    end

    -- Start with as many leaves as there are symbols
    -- Symbols[symbol] -> leaf
    local leafs = {}
    local symbols = {}
    for symbol, weight in pairs(hist) do
        local leaf = {
            symbol = symbol,
            weight = weight
        };
        symbols[symbol] = leaf;
        table.insert(leafs, leaf)
    end

    -- sort by probability in increasing order
    -- so that the least likely item is in the head of the queue
    table.sort( leafs,
                function(a,b)
                    if a.weight<b.weight then return true
                    elseif a.weight>b.weight then return false
                    else return nil end
                end )

    -- create Huffman tree
    local huff = {}
    -- While there is more than one node in the queues
    local l, h, li, hi, leaf1, leaf2
    while (#leafs + #huff > 1) do
        -- Dequeue the two nodes with the lowest weight
        -- Dequeue first
        if not next(huff) then
            li, leaf1 = next(leafs)
            table.remove(leafs, li)
        elseif not next(leafs) then
            hi, leaf1 = next(huff)
            table.remove(huff, hi)
        else
            li, l = next(leafs);
            hi, h = next(huff);
            if l.weight<=h.weight then
                leaf1 = l;
                table.remove(leafs, li)
            else
                leaf1 = h;
                table.remove(huff, hi)
            end
        end
        -- Dequeue second
        if not next(huff) then
            li, leaf2 = next(leafs)
            table.remove(leafs, li)
        elseif not next(leafs) then
            hi, leaf2 = next(huff)
            table.remove(huff, hi)
        else
            li, l = next(leafs);
            hi, h = next(huff);
            if l.weight<=h.weight then
                leaf2 = l;
                table.remove(leafs, li)
            else
                leaf2 = h;
                table.remove(huff, hi)
            end
        end

        --Create a new internal node
        local newNode = {
            left = leaf1,
            right = leaf2,
            weight = leaf1.weight + leaf2.weight
        }
        table.insert(huff, newNode)
    end
    -- for the case there are only one byte to encode
    if #leafs > 0 then
        li, l = next(leafs)
        table.insert(huff, l)
        table.remove(leafs, li)
    end

    -- assign codes to each symbol
    root = huff[1]
    genCode(root, 0, 0)
    if root then
        root.bcode = 0
        root.blength = 1
    end

    local compressed = {}
    local remainder = 0
    local remainder_length = 0
    -- encode the original uncompressed data
    for i = 1, #uncompressed do
        s = symbols[string.byte(uncompressed, i)]
        -- add symbol's bcode to compressed data
        remainder = remainder + bit32.lshift(s.bcode, remainder_length)
        remainder_length = s.blength + remainder_length
        if remainder_length > 32 then
            error('Bits lost due to too long code-words')
        end
        while remainder_length >= 8 do
            compressed[#compressed + 1] = string.char(bit32.band(remainder, 255))
            remainder = bit32.rshift(remainder, 8)
            remainder_length = remainder_length - 8
        end
    end
    if remainder_length > 0 then
        compressed[#compressed + 1] = string.char(remainder)
    end

    -- convert to string
    return symbols, table.concat(compressed, nil)
end

return Huffman_Encode
