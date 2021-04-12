
function print_poly(poly)
	for i in 1:length(poly)
		if poly[i] == 1
			print("x^$i ")
			continue
		end
		if poly[i] != 0
			print("$(poly[i])x^$i ")
		end
	end
	println()
end

function divide_poly(p1, p2)
	print_poly(p1)
	println("----------------")
	print_poly(p2)
end

function run()
	p1 = [1,2,3]
	p2 = [1,4,9]
	divide_poly(p1, p2)
end
run()
