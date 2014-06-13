local function serialize (fh, o, d)
    d = d or 1
    if type(o) == 'number' then
        fh:write(o)
    elseif type(o) == 'string' then
        -- %q formats a string between double quotes
        fh:write(("%q"):format(o))
    elseif type(o) == 'table' then
        fh:write("{\n")
        for k, v in pairs(o) do
            fh:write(("\t"):rep(d))
            fh:write("[")
            serialize(fh, k, d+1)
            fh:write("] = ")
            serialize(fh, v, d+1)
            fh:write(",\n")
        end
        fh:write(("\t"):rep(d-1), "}")
    else
        error("cannot serialize a " .. type(o))
    end
end

local a = {}
a.b = {
  c = 1,
  d = 2,
  e = {
    { {1, 2}, 3 },
    { {3, 4}, 7 },
  }
}

local file = io.open("a.txt", "w")
serialize(file, a)
io.close(file)

local file = io.open("a.txt", "r")
file:seek("set", 0)
for line in file:lines() do
    print(line)
end
io.close(file)
