function show_bits(val)
	for i in 0:(sizeof(val)-1)
		print((val&(1<<i))>>i)
	end
end


function new_poly(field, terms::Array{Int64})
	bits::Int64 = ceil(log2(field))
	if sizeof(Int128) < bits * length(terms)
		println("Too large")
		return
	end
	poly::Int128 = 0
	for i in 1:length(terms)
		poly += (terms[i]%field)<<((i-1)*bits)
	end
	return poly
end

function poly_deg(field, poly)
	bits = Int64(ceil(log2(field)))
	mask = (1<<bits)-1
	for i in sizeof(poly)-(sizeof(poly)%bits):-bits:0
		if poly&(mask<<i) != 0
			return Int64(i/bits)
		end
	end
end

function mul_poly(field, p1, p2)
	bits = Int64(ceil(log2(field)))
	p1_deg = poly_deg(field, p1)
	p2_deg = poly_deg(field, p2)
	out_deg = p1_deg + p2_deg
	if sizeof(Int128) < bits * out_deg
		println("Too large")
		return
	end
	p_large, p_small = p1_deg >= p2_deg ? (p1,p2) : (p2,p1)
	p_large_deg = max(p1_deg, p2_deg)
	p_small_deg = min(p1_deg, p2_deg)
	for k in 0:out_deg
		for i in min(p_large_deg, k):-1:min
	end
end



p1 = new_poly(5,[1,1,1])
p2 = new_poly(5,[2,1])

mul_poly(5, p1, p2)
