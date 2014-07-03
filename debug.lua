gvar = 11

function Inner( k )
    local lvar = {}
    lvar.a = 13
    print('k', k)   -- k    11
    debug.debug()   -- break point
    -- > debug.setlocal(3,1,-1)  -- (k = -1)
    -- > name, lvar = debug.getlocal(3,2)
    -- > print(name, lvar.a)
    -- lvar     13
    -- > print(debug.getlocal(4,2))
    -- y        5
    -- > print(debug.getlocal(5,1))
    -- a        2
    -- > for k, v in pairs(_G) do print(k,v) end
    -- gvar     11
    print "Program continues..."
end

function Middle( x, y )
    Inner( x+y )
end

function Outer( a, b, c )
    Middle( a*b, c )
end

function hook (event)
    local func_name = debug.getinfo(2,'n').name
    if func_name == 'Inner' then
        print(event, func_name) -- call Inner
        print( debug.traceback() )
    end
end

debug.sethook(hook, 'c')    -- hook function call
Outer( 2, 3, 5 )
debug.sethook()             -- turn off hook
