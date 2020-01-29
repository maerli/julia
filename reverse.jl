import Base.+
mutable struct D
    value
    children::Any
    grad_value::Real
end
function +(a::D,b::D)
    c = D(a.value + b.value,[],0)
    append!(a.children,(1,c))
    append!(b.children,(1,c))
    return c
end
function grad(a::D)
    s = 0
    if a.grad_value == 0
        s = sum([x for (x,r) in a.children]).value
    end
    return s
end
x = D(1,[],0)
y = D(1,[],0)
z = x+ x + y
println(x.children)
