Z		GREG	@
		LOC	Data_Segment
		GREG	@
Z_data		OCTA	#00800000ffffff00
		% Begin 7
		% End 8
		LOC	#100
Main		LDO	Z,Z_data
		FLOTU	$0,1,Z

		TRAP	0
