#from __future__ import xrange
#monte carlo method module
#https://www.ime.usp.br/~viviane/MAP2212/integralmc.pdf

#calculating PI with Monte Carlos Method

function monte_carlo(f,a,b,N=10)
	ds = rand(N,1) *(b-a)
	xs = [a + d for d in ds]
	ys = [f(x) for x in xs]
	return (b-a)*(1/N)*sum(ys)
end
f(x) = 4.0/(1 + x^2)
integral = monte_carlo(f,0,1,10000)
print(integral)
