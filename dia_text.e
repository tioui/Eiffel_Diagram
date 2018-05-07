note
	description: "Summary description for {DIA_TEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIA_TEXT

inherit
	DIA_ELEMENT


create
	make

feature {NONE} -- Initialization

	make(a_font:CAIRO_FONT_FACE)
			-- Initialisation of `Current' using `a_font' as `font'
		require
			a_font.is_valid
		do
			default_create
			set_font(a_font)
			text := ""
			set_size (10)
			align_horizontal_left
			align_vertical_bottom
		ensure
			Is_Assign: font ~ a_font
		end


feature -- Access

	text:READABLE_STRING_GENERAL assign set_text
			-- Value that `Current' have to `draw'

	set_text(a_text:READABLE_STRING_GENERAL)
			-- Assign `text' with the value of `a_text'
		do
			text := a_text.twin
		ensure
			Is_Assign: text ~ a_text
		end

	font:CAIRO_FONT_FACE assign set_font
			-- The font used to draw `Current'

	set_font(a_font:CAIRO_FONT_FACE)
			-- Assign `font' with the value of `a_font'
		require
			a_font.is_valid
		do
			font := a_font
		ensure
			Is_Assign: font ~ a_font
		end

	size:INTEGER assign set_size
			-- The size of applied to the `font' to `draw' `Current'

	set_size(a_size:INTEGER)
			-- Assign `size' with the value of `a_size'
		do
			size := a_size
		ensure
			Is_Assign: size ~ a_size
		end

	width:INTEGER
			-- <Precursor>
			-- This feature is context wise, so it must be added to a {DIA_DIAGRAM} to work.
			-- Will return 0 if not.
		require else
			Diagram_Attached: attached diagram
		local
			extents: CAIRO_TEXT_EXTENTS
		do
			if attached diagram as la_diagram then
				initialize_context_value(la_diagram.context)
				extents := la_diagram.context.text_extents (text)
				Result := extents.width.rounded
			else
				Result := 0
			end
		end

	height:INTEGER
			-- <Precursor>
			-- This feature is context wise, so it must be added to a {DIA_DIAGRAM} to work.
			-- Will return 0 if not.
		require else
			Diagram_Attached: attached diagram
		local
			extents: CAIRO_TEXT_EXTENTS
		do
			if attached diagram as la_diagram then
				initialize_context_value(la_diagram.context)
				extents := la_diagram.context.text_extents (text)
				Result := extents.height.rounded
			else
				Result := 0
			end
		end

	is_align_vertical_top:BOOLEAN
			-- `Current' is align vertically to the top

	align_vertical_top
			-- Vertically align `Current' to the top
		do
			clear_align_verical
			is_align_vertical_top := True
		ensure
			Is_Top_Set: is_align_vertical_top
			Is_Center_Unset: not is_align_vertical_center
			Is_Bottom_Unset: not is_align_vertical_bottom
		end

	is_align_vertical_center:BOOLEAN
			-- `Current' is centered vertically

	align_vertical_center
			-- Vertically center `Current'
		do
			clear_align_verical
			is_align_vertical_center := True
		ensure
			Is_Top_Unset: not is_align_vertical_top
			Is_Center_Set: is_align_vertical_center
			Is_Bottom_Unset: not is_align_vertical_bottom
		end

	is_align_vertical_bottom:BOOLEAN
			-- `Current' is align vertically to the bottom

	align_vertical_bottom
			-- Vertically align `Current' to the bottom
		do
			clear_align_verical
			is_align_vertical_bottom := True
		ensure
			Is_Top_Unset: not is_align_vertical_top
			Is_Center_Unset: not is_align_vertical_center
			Is_Bottom_Set: is_align_vertical_bottom
		end

	is_align_horizontal_left:BOOLEAN
			-- `Current' is align horizonally to the left

	align_horizontal_left
			-- Horizontally align `Current' to the left
		do
			clear_align_horizontal
			is_align_horizontal_left := True
		ensure
			Is_Left_Set: is_align_horizontal_left
			Is_Center_Unset: not is_align_horizontal_center
			Is_Right_Unset: not is_align_horizontal_right
		end

	is_align_horizontal_center:BOOLEAN
			-- `Current' is centered horizonally

	align_horizontal_center
			-- Horizontally center `Current'
		do
			clear_align_horizontal
			is_align_horizontal_center := True
		ensure
			Is_Left_Unset: not is_align_horizontal_left
			Is_Center_Set: is_align_horizontal_center
			Is_Right_Unset: not is_align_horizontal_right
		end

	is_align_horizontal_right:BOOLEAN
			-- `Current' is align horizonally to the right

	align_horizontal_right
			-- Horizontally align `Current' to the right
		do
			clear_align_horizontal
			is_align_horizontal_right := True
		ensure
			Is_Left_Unset: not is_align_horizontal_left
			Is_Center_Unset: not is_align_horizontal_center
			Is_Right_Set: is_align_horizontal_right
		end

feature {NONE} -- Implementation

	draw_stroke(a_context:CAIRO_CONTEXT)
			-- <Precursor>
		local
			l_x, l_y:INTEGER
		do
			l_x := x
			if is_align_horizontal_center then
				l_x := x - (width // 2)
			elseif is_align_horizontal_right then
				l_x :=x - width
			end
			l_y := y
			if is_align_vertical_center then
				l_y := y + (height // 2)
			elseif is_align_vertical_top then
				l_y :=y + height
			end
			initialize_context_value(a_context)
			a_context.set_font_face (font)
			a_context.move_to (l_x, l_y)
			a_context.text_path (text)
		end

	initialize_context_value(a_context:CAIRO_CONTEXT)
			-- <Precursor>
		do
			a_context.set_font_face (font)
			a_context.set_font_size (size)
		end

	clear_align_verical
			-- Unset every `is_align_vertical_*'
		do
			is_align_vertical_top := False
			is_align_vertical_center := False
			is_align_vertical_bottom := False
		ensure
			Is_Top_Unset: not is_align_vertical_top
			Is_Center_Unset: not is_align_vertical_center
			Is_Bottom_Unset: not is_align_vertical_bottom
		end

	clear_align_horizontal
			-- Unset every `is_align_horizontal_*'
		do
			is_align_horizontal_left := False
			is_align_horizontal_center := False
			is_align_horizontal_right := False
		ensure
			Is_Left_Unset: not is_align_horizontal_left
			Is_Center_Unset: not is_align_horizontal_center
			Is_Right_Unset: not is_align_horizontal_right
		end

invariant
	Font_Valid: font.is_valid
	Align_Vertical_Valid:
					(is_align_vertical_bottom or is_align_vertical_center or is_align_vertical_top) and
					(is_align_vertical_bottom implies (not is_align_vertical_center and not is_align_vertical_top)) and
					(is_align_vertical_center implies (not is_align_vertical_bottom and not is_align_vertical_top)) and
					(is_align_vertical_top implies (not is_align_vertical_center and not is_align_vertical_bottom))
	Align_Horizontal_Valid:
					(is_align_horizontal_left or is_align_horizontal_center or is_align_horizontal_right) and
					(is_align_horizontal_left implies (not is_align_horizontal_center and not is_align_horizontal_right)) and
					(is_align_horizontal_center implies (not is_align_horizontal_left and not is_align_horizontal_right)) and
					(is_align_horizontal_right implies (not is_align_horizontal_center and not is_align_horizontal_left))

end
