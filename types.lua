

print(type("hello world"))  -->string
print(type(123*12))         -->number
print(type(print))          -->function
print(type(type))           -->function
print(type(nil))            -->nil
print(type(X))              -->nil
-- no matter type of X, return of type is string
print(type(type(X)))        --string

---Variables have no predefined types
print()
print(type(a))              -->nil

a = 10
print(type(a))              -->number

a = false
print(type(a))              -->boolean

a = "a string"
print(type(a))              -->string

a = print
print(type(a))              -->function

---Lua has no integer type, as it does not need it
print()
a = 10; print(a)
a = .4; print(a)
a = 4.57e-3; print(a)
a = 4.57e20; print(a)
