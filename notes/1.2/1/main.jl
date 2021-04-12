function nicomachus(n)
	start = n^2 - n + 1
	other = n^2 - n
	return n*start + other
end
for i in 1:5
	val = nicomachus(i)	
	println("$(i)^3: $(val)")
end
