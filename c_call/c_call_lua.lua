
width = 200
height = 300
bg = {
    123,
    r = 0.3,
    g = 0.1,
    b = 0.0,
    d = {
      v = 0.5
    }
}

print("print from lua")

function func (str, x, y)
    print(str, ":", x, y)
    return math.sqrt(x^2+y^2), "from_lua"
end
