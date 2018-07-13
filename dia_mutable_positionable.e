note
	description: "Summary description for {DIA_MUTABLE_POSITIONABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIA_MUTABLE_POSITIONABLE


inherit
	DIA_POSITIONABLE


feature -- Access

	x:INTEGER assign set_x
			-- <Precursor>

	set_x(a_x:like x)
			-- Assign `a_x' to `x'
		do
			x := a_x
		ensure
			Is_Assign: x ~ a_x
		end

	y:INTEGER assign set_y
			-- <Precursor>

	set_y(a_y:like y)
			-- Assign `a_y' to `y'
		do
			y := a_y
		ensure
			Is_Assign: y ~ a_y
		end

end
