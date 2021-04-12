function run()
	s::Float64 = 0
	tolerance = 0.000000001
	for j in 0:100000000
		v = MathConstants.e^(-j)
		if v < tolerance
			println(j)
			break
		end
		s += v
	end
	println(s)

end
run()
