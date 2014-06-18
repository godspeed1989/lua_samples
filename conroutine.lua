co = coroutine.create(function ()
    print("hi")
end)

print(co)                       --> thread: 0x8071d98
--> a coroutine does not run its body when we create it
print(coroutine.status(co))     --> suspended
--> (re)starts the execution of a coroutine
coroutine.resume(co)            --> hi
--> leaving the coroutine in the dead state
print(coroutine.status(co))     --> dead
co = nil

-------------------------------------------------------
-- yield() allows a running coroutine to suspend
co = coroutine.create(function ()
    for i = 1, 3 do
        print("co", i)
        coroutine.yield()
    end
end)

coroutine.resume(co)            --> co  1
coroutine.resume(co)            --> co  2
coroutine.resume(co)            --> co  3
coroutine.resume(co)            --> (nothing)
-- resume() returns false plus an error message
status, err = coroutine.resume(co)
print(status, ":", err)
co = nil

-------------------------------------------------------
-- a pair resume-yield can exchange data between them
-- resume passes its extra arguments to the coroutine main function
co = coroutine.create(function (a,b,c)
    print("co", a,b,c)
end)
coroutine.resume(co, 1, 2, 3)           --> co  1  2  3

-- A call to resume returns, after the true that signals,
-- any arguments passed to the corresponding yield
co = coroutine.create(function (a,b)
    coroutine.yield(a + b, a - b)
end)
print(coroutine.resume(co, 20, 10))     --> true  30  10
