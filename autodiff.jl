import Base:+,-,*
struct D
  x::Real
  y::Real
end
+(a::D,b::D) = D(a.x+b.x,a.y+b.y)
+(a::Real,b::D) = D(a+b.x,b.y)
+(a::D,b::Real) = D(a.x+b,a.y)

-(a::D,b::D) = D(a.x - b.x,a.y - b.y)
-(a::Real,b::D) = D(a-b.x,-b.y)
-(a::D,b::Real) = D(a.x-b,a.x)

*(a::D,b::D) = D(a.x*b.x,a.x*b.y + a.y*b.x)
*(a::Real,b::D) = D(a*b.x,a*b.y)
*(a::D,b::Real) = D(a.x*b,a.y*b)

loss(a,b,x,y) = (a*x + b - y)*(a*x + b - y)

function serialize(f,index,xs)
	values = [D(x,i == index ? 1 : 0) for (i,x) in enumerate(xs)]
	return f(Tuple(values)...)
end
change(i,j) = i == j ? 1 : 0
function gradient(f,xs,lr,iter)
    v = [ x for x in xs]
    for i in 1:iter
		for j in 1:length(v)
			rest = serialize(f,j,v)
			v[j] = v[j] - lr*rest.y
		end
	end
	#print(v)
    return Tuple(v)
end
loss(a,b,x,y) = (a*x + b - y)*(a*x + b - y)

function minimize(xs,ys,lr,iter)
	Error(a,b) = sum([loss(a,b,xs[i],ys[i]) for i in 1:length(xs)])
	xi = [1.0,0.0]
	
	return gradient(Error,Tuple(xi),lr,iter)
end

f(x) = 1*x + 4.0
xs = [x/20.0 for x in 1:20]
ys = [f(x)/20 for x in xs]


a = minimize(xs,ys,0.01,10000)


println(a[1],"{}",a[2])