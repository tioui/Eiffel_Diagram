note
	description: "Every element on a {DIA_DIAGRAM}."
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

deferred class
	DIA_OBJECT

inherit
	DIA_FILLABLE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			has_error := False
			Precursor
			internal_stroke_pattern := <<>>
			stroke_size := 1
			set_fill_color (1.0, 1.0, 1.0, 0.0)
			set_stroke_color (0.0, 0.0, 0.0, 1.0)
		end

feature -- Access

	has_error:BOOLEAN
			-- An error occured on the last operation

	draw
			-- Draw `Current' on `a_context'
		require
			Valid: is_valid
		do
			if attached diagram as la_diagram then
				la_diagram.context.save_state
				la_diagram.context.set_line_width (stroke_size)
				la_diagram.context.set_dashes (internal_stroke_pattern, stroke_pattern_offset)
				la_diagram.context.set_source_rgba (stroke_color.red, stroke_color.green, stroke_color.blue, stroke_color.alpha)
				draw_stroke(la_diagram.context)
				la_diagram.context.set_source_rgba (fill_color.red, fill_color.green, fill_color.blue, fill_color.alpha)
				la_diagram.context.fill_preserve
				la_diagram.context.set_source_rgba (stroke_color.red, stroke_color.green, stroke_color.blue, stroke_color.alpha)
				la_diagram.context.stroke
				la_diagram.context.restore_state
			end
		end

	stroke_color:TUPLE[red, green, blue, alpha:REAL_64]
			-- The color of the stroke of `Current' (values between 0 and 1).

	set_stroke_color(a_red, a_green, a_blue, a_alpha:REAL_64)
			-- Assign `stroke_color' with the value of `a_red', `a_green', `a_blue' and `a_alpha'
		require
			Red_Valid: a_red >= 0 and a_red <= 1
			Green_Valid: a_green >= 0 and a_green <= 1
			Blue_Valid: a_blue >= 0 and a_blue <= 1
			Alpha_Valid: a_alpha >= 0 and a_alpha <= 1
		do
			stroke_color := [a_red, a_green, a_blue, a_alpha]
		ensure
			Is_Red_Assign: stroke_color.red ~ a_red
			Is_Green_Assign: stroke_color.green ~ a_green
			Is_Blue_Assign: stroke_color.blue ~ a_blue
			Is_Alpha_Assign: stroke_color.alpha ~ a_alpha
		end

	stroke_size:INTEGER
			-- Dimension of the stroke

	set_stroke_size(a_stroke_size:INTEGER)
			-- Assign `stroke_size' with the value of `a_stroke_size'
		require
			Stroke_Size_Positive: a_stroke_size >= 0
		do
			stroke_size := a_stroke_size
		ensure
			Is_Assign: stroke_size ~ a_stroke_size
		end


	stroke_pattern:LIST [INTEGER]
			-- The dashes pattern in the stroke as an {ARRAY} form
			-- Each value provides the length of alternate "on"
			-- and "off" portions of the stroke.
		do
			create {ARRAYED_LIST[INTEGER]}Result.make (internal_stroke_pattern.count)
			across internal_stroke_pattern as la_pattern loop
				Result.extend (la_pattern.item.rounded)
			end
		end

	set_stroke_pattern(a_pattern:LIST [INTEGER])
			-- Assign `stroke_pattern' with the value of `a_pattern'
		require
			pattern_not_all_0: a_pattern.is_empty or across
					a_pattern as la_pattern
				some
					la_pattern.item > 0
				end
			pattern_not_negative: not (across
					a_pattern as la_pattern
				some
					la_pattern.item < 0
				end)
		local
			l_index:INTEGER
		do
			create internal_stroke_pattern.make_filled (0.0, 1, a_pattern.count)
			l_index := 1
			across a_pattern as la_pattern loop
				internal_stroke_pattern.at (l_index) := la_pattern.item
				l_index := l_index + 1
			end
		ensure
			Is_Assign: attached stroke_pattern as la_pattern and then
							a_pattern.count = la_pattern.count and then
							across 1 |..| a_pattern.count as la_index all a_pattern.at (la_index.item) ~ la_pattern.at (la_index.item) end
		end

	stroke_pattern_offset:INTEGER assign set_stroke_pattern_offset
			-- Offset into the stroke where the `stroke_pattern' begins

	set_stroke_pattern_offset(a_pattern_offset:INTEGER)
			-- Assign `stroke_pattern_offset' with the value of `a_pattern_offset'
		do
			stroke_pattern_offset := a_pattern_offset
		ensure
			Is_Assign: stroke_pattern_offset ~ a_pattern_offset
		end

	diagram:detachable DIA_DIAGRAM
			-- The {DIA_DIAGRAM} containing `Current'

	is_valid:BOOLEAN
			-- `Current' can be used
		do
			Result := not has_error and attached diagram
		end

feature {NONE} -- Implementation

	draw_stroke(a_context:CAIRO_CONTEXT)
			-- Draw `Current' on `a_context'
		deferred
		end

	internal_stroke_pattern:ARRAY[REAL_64]
			-- The internal values of `stroke_pattern'


feature {DIA_DIAGRAM} -- Implementation

	update_context
			-- `diagram' has change context and `Current' have to be updated accordingly
		do
		end

	set_diagram(a_diagram:detachable DIA_DIAGRAM)
			-- Assign `diagram' with the value of `a_diagram'
		do
			diagram := a_diagram
			update_context
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
