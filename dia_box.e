note
	description: "A box {DIA_ELEMENT}"
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

class
	DIA_BOX

inherit
	DIA_ELEMENT

feature {NONE} -- Implementation

	draw_stroke(a_context:CAIRO_CONTEXT)
			-- <Precursor>
		do
			a_context.move_to (x, y)
			a_context.line_to (x + width, y)
			a_context.line_to (x + width, y + height)
			a_context.line_to (x, y + height)
			a_context.line_to (x, y)
		end
end
