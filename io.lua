local gmatch
if _VERSION >= "Lua 5.1" then
    gmatch = string.gmatch
else
    gmatch = string.gsub
end

local f = assert(io.open(arg[0], "rb"))
-- hex dump a file
local block = 16
while true do
    local bytes = f:read(block)
    if not bytes then break end
    for b in gmatch(bytes, '.') do
        io.write(('%02X '):format(string.byte(b)))
    end
    io.write(string.rep('   ', block - #bytes + 1))
    io.write(string.gsub(bytes, "%c", "."), "\n")
end

local function fsize (file)
    local current = file:seek()
    local size = file:seek('end')
    file:seek('set', current)
    return size
end
print(type(f))          --> userdata
print(fsize(f))         --> ${size of file}

io.close(f)
