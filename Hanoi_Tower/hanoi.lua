-- Towers of Hanoi problem solver implementation

-- Move n disks from Src to Dst via Tmp
-- n:   The number of disks to move
-- Src: The source tower
-- Dst: The destination tower
-- Log: (optional) a table to save the procedure trace
local function move (n, Src, Dst, Tmp, Log)
    if n > 0 then
        move(n-1, Src, Tmp, Dst, Log)
        if Log then table.insert(Log, ('%s->%s'):format(Src, Dst)) end
        move(n-1, Tmp, Dst, Src, Log)
    end
end

return move
