function receive (prod)
    local status, value = coroutine.resume(prod)
    return value
end

function send (x)
    coroutine.yield(x)
end

function producer ()
    return coroutine.create(
        function ()
            while true do
                io.write("producer > ")
                local x = io.read()
                send(x)
            end
        end
    )
end

function filter (prod)
    return coroutine.create(
        function ()
            while true do
                local x = receive(prod)
                x = string.upper(x)
                send(x)
            end
        end
    )
end

function consumer (prod)
    while true do
        local x = receive(prod)
        io.write("consumer < ", x, "\n")
        if x == '.Q' then
            os.exit()
        end
    end
end

consumer(filter(producer()))
-- p = producer()
-- f = filter(p)
-- consumer(f)
