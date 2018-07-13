note
	description: "Summary description for {DIA_ARROW_MARKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIA_ARROW_MARKER

inherit
	DIA_MARKER
		redefine
			default_create
		end

create
	default_create,
	make

feature {NONE} -- Implementation

	default_create
			-- <Precursor>
		do
			Precursor
			cap_psition := [0,0]
			base_1_psition := cap_psition
			base_2_psition := cap_psition
		end

	make(a_angle, a_height:INTEGER)
			-- Initialization of `Current' using `a_angle' as `angle' and `a_height' as `height'
		do
			default_create
			height := a_height
			set_angle(a_angle)
		end

feature -- Access

	cap_psition:TUPLE[x, y:INTEGER]
			-- The coordinates of the cap of `Current'

	base_1_psition:TUPLE[x, y:INTEGER]
			-- The coordinates of the cap of `Current'

	base_2_psition:TUPLE[x, y:INTEGER]
			-- The coordinates of the cap of `Current'

	angle:INTEGER assign set_angle
			-- The angle (in degree) that generate the width of `Current'

	set_angle(a_angle:INTEGER)
			-- Assign `angle' with the value of `a_angle' (in degree)
		do
			if a_angle /~ angle then
				angle := a_angle
				update_coordinates
			end
		ensure
			Is_Assign: angle ~ a_angle
		end

	height:INTEGER
			-- The distance between the `cap_position' and the middle of the two bases

	set_height(a_height:INTEGER)
			-- Assign `height' with the value of `a_height'
		do
			if a_height /~ height then
				height := a_height
				update_coordinates
			end
		ensure
			Is_Assign: height ~ a_height
		end




feature {NONE} -- Implementation

	draw_stroke(a_context:CAIRO_CONTEXT)
			-- <Precursor>
		do
			a_context.move_to (cap_psition.x, cap_psition.y)
			a_context.line_to (base_1_psition.x, base_1_psition.y)
			a_context.line_to (base_2_psition.x, base_2_psition.y)
			a_context.line_to (cap_psition.x, cap_psition.y)
		end

	update_coordinates
			-- Update the coordinates used to `draw' `Current'
		do
		end
end
