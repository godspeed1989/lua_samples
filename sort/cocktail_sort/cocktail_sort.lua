
return function (list, comp)
    comp = comp or function(a, b) return a < b end
    local begin, _end = 1, #list

    while begin < _end do
        local swapped
        -- begin to end
        swapped = false
        for i = begin, _end-1 do
            if not comp(list[i], list[i+1]) then
                list[i], list[i+1] = list[i+1], list[i]
                swapped = true
            end
        end
        if not swapped then break
        else _end = _end - 1 end

        -- end to begin
        swapped = false
        for i = _end, begin+1, -1 do
            if not comp(list[i-1], list[i]) then
                list[i-1], list[i] = list[i], list[i-1]
                swapped = true
            end
        end
        if not swapped then break
        else begin = begin + 1 end
    end

    return list
end
