-- (In-place) Quicksort implementation

local function partition (list, comp, left, right, pivot_index)
    local pivot_value = list[pivot_index]
    -- Exchange pivot with right
    list[pivot_index], list[right] = list[right], list[pivot_index]
    local store_index = left
    for i = left, right-1 do
        if comp(list[i], pivot_value) then
            list[i], list[store_index] = list[store_index], list[i]
            store_index = store_index + 1
        end
    end
    -- Put back pivot
    list[store_index], list[right] = list[right], list[store_index]
    return store_index
end

local function quicksort (list, comp, left, right)
    left, right = left or 1, right or #list
    if left < right then
        local pivot_index = math.random(left, right)
        local new_pivot_index;
        new_pivot_index = partition(list, comp, left, right, pivot_index)
        quicksort(list, comp, left, new_pivot_index - 1)
        quicksort(list, comp, new_pivot_index + 1, right)
    end
    return list
end

return function (list, comp)
    comp = comp or function (a, b) return a < b end
    return quicksort(list, comp)
end
