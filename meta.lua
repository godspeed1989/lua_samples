-- A metatable controls how an object behaves
-- __index : Indexing access table[key]
-- __newindex : Indexing assignment table[key] = value
--   index and newindex only tried when key is not present
-- __add : the + operation
-- __len : the # operation
-- __call : called when Lua calls a value

local Union = {
    data    = nil,
}

function Union:new()
    local b = {}
    setmetatable(b, self)
    self.__index = self
    return b
end

function Union:init(data)
    if data and type(data) ~= "table" then
        error("Init data should table type")
    end
    self.data = data or {}
    self.exist = true
    local meta = {}
    -- access table[key]
    meta.__index = function (tbl, key)
        print("__index   ", key)
        if Union[key] ~= nil then
            return Union[key]
        else
            return self.data[key]
        end
    end
    -- assignment table[key] = value
    meta.__newindex = function (tbl, key, value)
        print("__newindex", key, value)
        self.data[key] = value
    end
    -- the + operation
    meta.__add = function (op1, op2)
        print("__add     ")
        for key, value in pairs(op2.data) do
            op1.data[key] = value
        end
        return op1
    end
    -- the # operation
    meta.__len = function (op)
        print("__len     ")
        local l = 0
        for _, _ in pairs(op.data) do
            l = l + 1
        end
        return l
    end
    -- called when Lua calls a value
    meta.__call = function (tbl, ...)
        print("__call    ")
        local sum = 0
        for key, value in ipairs{...} do
            sum = sum + value
        end
        print(sum)
    end
    setmetatable(self, meta)
end

local u1 = Union:new()
data1 = {point = 3}
u1:init(data1)
p = u1.point    --> __index     point
u1.point = 4    --> __newindex  point   4
print(("-"):rep(30))    -----------------------------
local u2 = Union:new()
u2:init()
e = u2.exist    --> (no output, u2[exist] is present)
u2.exist = 2    --> (no output, u2[exist] is present)
u2.x = 0.11     --> __newindex  x       0.11
u2.y = 0.22     --> __newindex  y       0.22
u2.point = 0.33 --> __newindex  point   0.33
d = math.sqrt(u2.x^2 + u2.y^2)
                --> __index     x
                --> __index     y
print(("-"):rep(30))    -----------------------------
local u3 = u1 + u2
for key, value in pairs(u3.data) do
    print(key, value)   --> point   0.33
end
print(("-"):rep(30))    -----------------------------
print(#u3)              --> __len   3
print(("-"):rep(30))    -----------------------------
u3(1, 2, 3)             --> __call  6
