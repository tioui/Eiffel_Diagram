note
	description: "Summary description for {DIA_ANCHOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIA_ANCHOR

inherit
	DIA_POSITIONABLE

feature {DIA_LINK} -- Implementation

	anchor_point(a_source_x, a_source_y:INTEGER):TUPLE[x, y:INTEGER]
			-- The the position of the point where the {DIA_LINK} should end
			-- consideraing that the {DIA_LINK} start at `a_source_x', `a_source_y'
		deferred
		end


end
