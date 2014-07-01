-- Mergesort top down implementation

-- Merge two sorted array [left..mid], [mid+1..right]
local function merge(list, left, mid, right, comp)
    local llen, rlen = mid, right
    local lindex, rindex = left, mid+1
    local t = {}

    repeat
        if lindex <= llen and rindex <= rlen then
            if comp(list[lindex], list[rindex]) then
                t[#t + 1] = list[lindex]
                lindex = lindex + 1
            else
                t[#t + 1] = list[rindex]
                rindex = rindex + 1
            end
        elseif lindex <= llen then
            t[#t + 1] = list[lindex]
            lindex = lindex + 1
        else
            t[#t + 1] = list[rindex]
            rindex = rindex + 1
        end
    until (lindex > llen and rindex > rlen)

    local j = 1
    for i=left, right do
        list[i] = t[j]
        j = j + 1
    end
end

-- Merge sort: top down split merge implementation
-- list: a list to be sorted
-- left, right: two ends of list
-- comp: a comparison function
local function merge_sort(list, left, right, comp)
    if left >= right then return end
    local mid = math.floor((left + right)/2)
    merge_sort(list, left, mid, comp)
    merge_sort(list, mid+1, right, comp)
    merge(list, left, mid, right, comp)
end

return function (list, comp)
    comp = comp or function(a, b) return a < b end
    merge_sort(list, 1, #list, comp)
    return list
end
