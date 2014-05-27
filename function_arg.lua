function print_args (...)
    local printResult = ""
    print(arg.n)            --> 3 (number of args)
    for i,v in ipairs(arg) do
        printResult = printResult .. tostring(v) .. "\t"
    end
    print(printResult)
end
print_args("a1", "a2", 3)   --> a1  a2  3

print()
print(string.find("hello hello", " hel"))            --> 6  9
print(select(1, string.find("hello hello", " hel"))) --> 6  9
print(select(2, string.find("hello hello", " hel"))) --> 9
print(select(3, string.find("hello hello", " hel"))) --> no output

function rename (arg)
    os.rename(arg.old, arg.new)
end
rename{old="temp.lua", new="temp1.lua"}
-- rename(old="temp.lua", new="temp1.lua") invalid

---[[
function Window (options)
    if type(options.title) ~= "string" then
        error("no title")
    elseif type(options.width) ~= "number" then
        error("no width")
    elseif type(options.height) ~= "number" then
        error("no height")
    end

    -- everything else is optional
    _Window( options.title,
             options.x or 0,    -- default value
             options.y or 0,    -- default value
             options.width, options.height,
             options.background or "white",   -- default
             options.border      -- default is false (nil)
    )
end

w = Window{ x=0, y=0, width=300, height=200,
            title = "Lua", background="blue",
            border = true }
--]]

-- higher-order function
network = {
    {name = "grauna",   IP = "210.26.30.34"},
    {name = "arraial",  IP = "210.26.30.23"},
    {name = "lua",      IP = "210.26.23.12"},
}
-- Function that gets another function as an argument
table.sort(network, function (a,b)
           return (a.name > b.name) end)
