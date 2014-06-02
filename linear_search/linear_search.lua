-- Linear search algorithm implementation
-- See: http://en.wikipedia.org/wiki/Linear_search

local function forward_iteration(array, item)
    for i, value in ipairs(array) do
        if item == value then return i end
    end
end

local function backward_iteration(array, item)
    for i = #array, 1, -1 do
        if array[i] == item then return i end
    end
end

return {
    forward = forward_iteration,
    backward = backward_iteration,
}
