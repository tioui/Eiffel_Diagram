note
	description: "Summary description for {DIA_TEXT_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
			-- ToDo
		local
			l_distance, l_new_distance:REAL_64
			l_source:TUPLE[x, y:REAL_64]
			l_result:TUPLE[point:detachable TUPLE[x, y:REAL_64]; distance:REAL_64]
			l_center:TUPLE[x, y:INTEGER]
		do
			l_center := [x + (width // 2), y + (height // 2)]
			l_source := [a_source_x.to_double, a_source_y.to_double]
			l_distance := {REAL_64}.positive_infinity
			l_result := [Void, {REAL_64}.positive_infinity]
			l_result := validate_point(
								l_result,
								find_intersect([x, y, x + width, y], [a_source_x, a_source_y, l_center.x, l_center.y]),
								l_source
							)
			l_result := validate_point(
								l_result,
								find_intersect([x, y, x, y + height], [a_source_x, a_source_y, l_center.x, l_center.y]),
								l_source
							)
			l_result := validate_point(
								l_result,
								find_intersect([x + width, y, x + width, y + height], [a_source_x, a_source_y, l_center.x, l_center.y]),
								l_source
							)
			l_result := validate_point(
								l_result,
								find_intersect([x, y + height, x + width, y + height], [a_source_x, a_source_y, l_center.x, l_center.y]),
								l_source
							)
			if attached l_result.point as la_point then
				Result := [la_point.x.rounded, la_point.y.rounded]
			else
				Result := [l_center.x, l_center.y]
			end
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

end
