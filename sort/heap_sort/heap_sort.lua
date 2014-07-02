-- Heap sort implementation

local function sift_up (heap, index)
    local pIndex = math.floor(index / 2)
    if index < 1 or pIndex < 1 then return end
    -- sift up
    if not heap._sort(heap._array[pIndex], heap._array[index]) then
        heap._array[pIndex], heap._array[index] =
            heap._array[index], heap._array[pIndex]
        sift_up(heap, pIndex)
    end
end

local function sift_down (heap, index)
    local minIndex
    local lfIndex = 2 * index
    local rtIndex = lfIndex + 1
    -- get minimum from left and right
    if lfIndex > #heap._array then
        return
    elseif rtIndex > #heap._array then
        minIndex = lfIndex
    else
        if heap._sort(heap._array[lfIndex], heap._array[rtIndex]) then
            minIndex = lfIndex
        else
            minIndex = rtIndex
        end
    end
    -- sift down
    if not heap._sort(heap._array[index], heap._array[minIndex]) then
        heap._array[index], heap._array[minIndex] = heap._array[minIndex], heap._array[index]
        sift_down(heap, minIndex)
    end
end

local function f_min(a,b) return a < b end

-- build heap
local function heapify (heap, array)
    for i, value in ipairs(array) do
        heap._array[#heap._array + 1] = value
        sift_up(heap, #heap._array)
    end
end

-- heap sort
local function heap_sort (sorted, heap)
    while #heap._array > 0 do
        local root = heap._array[1]
        heap._array[1] = heap._array[#heap._array]
        table.remove(heap._array)
        sift_down(heap, 1)
        sorted[#sorted + 1] = root
    end
end

return function (array, comp)
    local heap = {
        _array = {},
        _sort = comp or f_min
    }
    -- build heap
    heapify(heap, array)
    -- heap sort
    local ret = {}
    heap_sort(ret, heap)
    return ret
end
