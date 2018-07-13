note
	description: "Summary description for {DIA_ANCHOR_POINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIA_ANCHOR_POINT

inherit
	DIA_ANCHOR
		redefine
			default_create
		end
	DIA_MUTABLE_POSITIONABLE
		redefine
			default_create
		end
create
	default_create,
	make

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			set_x(0)
			set_y(0)
		end

	make(a_x, a_y:INTEGER)
			-- Initialization of `Current' using `a_x' as `x' and `a_y' as `y'
		do
			set_x(a_x)
			set_y(a_y)
		ensure
			Is_X_Assing: x ~ a_x
			Is_Y_Assing: y ~ a_y
		end
feature {DIA_LINK} -- Implementation

	anchor_point(a_source_x, a_source_y:INTEGER):TUPLE[x, y:INTEGER]
			-- <Precursor>
		do
			Result := [x, y]
		end
end
