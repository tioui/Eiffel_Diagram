note
	description: "A {DIA_MARKER} representing an arrow."
	author: "Louis Marchand"
	date: "Tue, 24 Jul 2018 13:45:38 +0000"
	revision: "0.1"

class
	DIA_ARROW_MARKER

inherit
	DIA_MARKER
		redefine
			default_create
		end
	DOUBLE_MATH
		redefine
			default_create
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			Precursor {DIA_MARKER}
			set_width (10)
			set_height (10)
		end

	make(a_width, a_height:INTEGER)
			-- Initialization of `Current' using dimension (`a_width' x `a_height')
		do
			default_create
			set_width (a_width)
			set_height (a_height)
			angle := 0
		end

feature -- Access

	angle:REAL_64
			-- The angle (in radian) that generate the width of `Current'



feature {DIA_LINK} -- Implementation

	gap:REAL_64
			-- <Precursor>
		do
			Result := height - (height / 10)
		end


feature {NONE} -- Implementation

	Base_width:INTEGER = 100
			-- The `width' representing a pixel

	Base_height:INTEGER = 100
			-- The `height' representing a pixel

	Base_1_psition:TUPLE[x, y:REAL_64]
			-- The coordinates of the first base point of `Current'
			-- (relative to `destination_x' and `destination_y')
		once
			Result :=  [-(Base_width / 2), (Base_height.to_double)]
		end

	Base_2_psition:TUPLE[x, y:REAL_64]
			-- The coordinates of the second base point of `Current'
			-- (relative to `destination_x' and `destination_y')
		once
			Result :=  [Base_width.to_double, 0.0]
		end

	Base_3_psition:TUPLE[x, y:REAL_64]
			-- The coordinates of the third base point of `Current'
			-- (relative to `destination_x' and `destination_y')
		once
			Result :=  [-(Base_width / 2), -(Base_height.to_double)]
		end

	relative_width:REAL_64
			-- Equivalent to `width' / `Base_width'

	relative_height:REAL_64
			-- Equivalent to `height' / `Base_height'

	draw_stroke(a_context:CAIRO_CONTEXT)
			-- <Precursor>
		do

			a_context.move_to (destination_x, destination_y)
			a_context.rotate (angle)
			a_context.scale (width / Base_width, height / Base_height)
			a_context.relative_line_to (base_1_psition.x, base_1_psition.y)
			a_context.relative_line_to (base_2_psition.x, base_2_psition.y)
			a_context.relative_line_to (base_3_psition.x, base_3_psition.y)
		end

	update_coordinates
			-- Update the coordinates used to `draw' `Current'
		do
			if is_start then
				angle := arc_tangent ((source_y - destination_y) / (source_x - destination_x)) - Pi_2
			else
				angle := arc_tangent ((source_y - destination_y) / (source_x - destination_x)) + Pi_2
			end
			relative_width := width / Base_width
			relative_height := height / Base_height
		end

invariant
	Relative_Width_Valid: relative_width = width / Base_width
	Relative_Height_Valid: relative_height = height / Base_height

note
	copywrite: "Copyright (c) 2018, Louis Marchand"
	license: "[
				Permission is hereby granted, free of charge, to any person obtaining a
				copy of this software and associated documentation files (the "Software"),
				to deal in the Software without restriction, including without limitation
				the rights to use, copy, modify, merge, publish, distribute, sublicense,
				and/or sell copies of the Software, and to permit persons to whom the
				Software is furnished to do so, subject to the following conditions:

				The above copyright notice and this permission notice shall be included
				in all copies or substantial portions of the Software.

				THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
				OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
				FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
				THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
				LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
				FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
				DEALINGS IN THE SOFTWARE.
		]"
end
