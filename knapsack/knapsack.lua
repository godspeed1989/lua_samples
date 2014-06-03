-- Performs standard 0/1 Knapsack.
-- This implementation uses dynamic programming.
-- items   : an array of items (see note before).
-- capacity: the maximum capacity of the knapsack
-- returns : 1. an array of items
--           2. the maximum profit
local function Knapsack(items, capacity)
    local numOfItems = #items
    local V, K = {}, {}

    -- Initial auxiliary tables with 0's
    for i = 0, numOfItems do
        V[i], K[i] = {}, {}
        for w = 0, capacity do
            V[i][w], K[i][w] = 0, 0
        end
    end

    -- Dynamic search
    for i = 1, numOfItems do
        local iw = items[i].w   -- weight
        local ip = items[i].p   -- price
        for w = 0, capacity do
            if iw < w and
               (ip + V[i-1][w-iw] > V[i-1][w]) then
                V[i][w] = ip + V[i-1][w-iw]
                K[i][w] = 1
            else
                V[i][w] = V[i-1][w]
                K[i][w] = 0
            end
        end
    end

    -- Identify selected and evaluate profit
    local inKnapsack = {}
    local profit = 0
    for i = numOfItems, 1, -1 do
        local iw = items[i].w   -- weight
        local ip = items[i].p   -- price
        if K[i][capacity] == 1 then
            table.insert(inKnapsack, items[i])
            capacity = capacity - iw
            profit = profit + ip
        end
    end

    return inKnapsack, profit
end

return Knapsack
