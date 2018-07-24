note
	description: "A {DIA_BOX} that contain text"
	author: "Louis Marchand"
	date: "Tue, 24 Jul 2018 13:45:38 +0000"
	revision: "0.1"

class
	DIA_TEXT_BOX

inherit
	DIA_BOX
		rename
			height as minimum_height,
			set_height as set_minimum_height
		redefine
			draw, set_width, is_valid, set_diagram, draw_stroke, anchor_point
		end
	PANGO_CONSTANTS
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make(a_font_text:READABLE_STRING_GENERAL)
			-- Initialisation of `Current' using `a_font_text' to initialize `font_description'
		require
			Font_Text_Not_Empty: not a_font_text.is_empty
		do
			default_create
			create text.make(a_font_text)
			text.align_horizontal_center
			text.align_vertical_center
		end

feature -- Access

	draw
			-- <Precursor>
		do
			Precursor
			update_text_position
			text.draw
		end

	text:DIA_TEXT_FIXED
			-- The text to show in `Current'

	set_width (a_width: like width)
			-- <Precursor>
		do
			Precursor(a_width)
			if attached text.layout as la_layout then
				la_layout.set_width (a_width * PANGO_SCALE)
			end
		end

	height:INTEGER
			-- The actual height of `Current' (maximum between `minimum_height' and `text'.`height')
		do
			Result := minimum_height
			if text.is_valid then
				Result := Result.max(text.height)
			end
		end

	is_valid:BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and text.is_valid
		end

feature {DIA_DIAGRAM} -- Implementation

	set_diagram(a_diagram:detachable DIA_DIAGRAM)
			-- Assign `diagram' with the value of `a_diagram'
		do
			diagram := a_diagram
			text.set_diagram(a_diagram)
			set_width(width)
		end

feature {DIA_LINK} -- Implementation

	anchor_point(a_source_x, a_source_y:INTEGER):TUPLE[x, y:INTEGER]
			-- <Precursor>
		do
			Result := anchor_point_with_height(a_source_x, a_source_y, height)
		end


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

	update_text_position
			-- Update the `text' `x' and `y' using the `x', `y', `width' and `height' of `Current'
		do
			text.set_x (x + (width // 2))
			text.set_y (y + (height // 2))
		end

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
