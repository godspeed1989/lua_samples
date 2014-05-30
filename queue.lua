List = {
    first = 0,
    last = -1
}

function List:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function List:pushleft (value)
    local first = self.first - 1
    self.first = first
    self[first] = value
end

function List:pushright (value)
    local last = self.last + 1
    self.last = last
    self[last] = value
end

function List:popleft ()
    local first = self.first
    if first > self.last then
        error ("list is empty")
    end
    local value = self[first]
    list[first] = nil -- garbage collection 
    self.first = first + 1
    return value
end

function List:popright()
    local last = self.last
    if list.first > last then
        error ("list is empty")
    end
    local value = list[last]
    list[last] = nil -- garbage collection
    list.last = last - 1
    return value
end

list = List:new()
list:pushleft(-11)
list:pushright(11)
print(list.first, list.last)                --> -1  0
print(list[list.first], list[list.last])    --> -11 11
print(list:popleft(), list:popleft())       --> -11 11
print()
list:pushleft(-22)
list:pushright(22)
print(list.first, list.last)                --> -1  0
print(list[list.first], list[list.last])    --> -22 22
print(list:popright(), list:popright())     --> 22  -22
