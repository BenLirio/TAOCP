using BenchmarkTools

function factorial(n)
	val::BigInt = 1
	for i in 1:n
		val = val * i
	end
	return val
end
function stirlings(n)
	e = Base.MathConstants.e
	a = (2.0*pi)^(0.5)
	b::BigFloat = ((n+.5)/e)^(n	+ 0.5)
	return a*b
end
function stirlings_approx(n)
	e = Base.MathConstants.e
	return (2*pi*n)^(0.5)*(n/e)^n
end
function gamma(n)
	m::BigFloat = 100
	div::BigFloat = 1
	for i in 1:m
		div *= n+i
	end
	return ((m^n)*factorial(m))/div
end

function run()
	for n::BigInt in 100:100
		factorial_res = factorial(n)
		stirlings_res = stirlings(n)
		stirlings_approx_res = stirlings_approx(n)
		gamma_res = gamma(n)
		#println(abs(factorial_res-gamma_res)/factorial_res)
		println((factorial_res-gamma_res)/factorial_res)
	end
end

run()
