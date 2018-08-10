note
	description: "[
					A text that can be writen in a {DIA_DIAGRAM} that canot change it's position or alignment
					Should be used as an ancestor for {DIA_ELEMENT} that use text.
				]"
	author: "Louis Marchand"
	date: "Tue, 24 Jul 2018 13:45:38 +0000"
	revision: "0.1"

class
	DIA_TEXT_FIXED


inherit
	DIA_ELEMENT
		export
			{DIA_TEXT_BOX} set_x, set_y;
			{DIA_DIAGRAM, DIA_TEXT_BOX} set_diagram
		redefine
			is_valid, update_context
		end

create {DIA_ELEMENT}
	make

feature {NONE} -- Initialization

	make(a_font_text:READABLE_STRING_GENERAL)
			-- Initialisation of `Current' using `a_font_text' to initialize `font_description'
		require
			Font_Text_Not_Empty: not a_font_text.is_empty
		do
			default_create
			set_font_by_text (a_font_text)
			align_horizontal_left
			align_vertical_bottom
		end

feature -- Access

	text:READABLE_STRING_GENERAL assign set_text
			-- Value that `Current' have to `draw'
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				Result := la_layout.text
			else
				Result := ""
			end
		end

	set_text(a_text:READABLE_STRING_GENERAL)
			-- Assign `text' with the value of `a_text'
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				la_layout.set_text (a_text)
			end
		ensure
			Is_Assign: text.to_string_32 ~ a_text.to_string_32
		end

	font_description:PANGO_FONT_DESCRIPTION assign set_font_description
			-- The font used to draw `Current'

	set_font_description(a_font_description:PANGO_FONT_DESCRIPTION)
			-- Assign `font_description' with the value of `a_font_description
		require
			a_font_description.exists
		do
			font_description := a_font_description
		ensure
			Is_Assign: font_description ~ a_font_description
		end

	set_font_by_text(a_font_text:READABLE_STRING_GENERAL)
			-- Gnerate a new `font_description' from `a_font_text'
			-- If `a_font_text' is not valid, `has_error' will be set.
		require
			Font_Text_Not_Empty: not a_font_text.is_empty
		do
			create font_description.make_from_text (a_font_text)
		end

	size:INTEGER assign set_size
			-- The size of applied to the `font' to `draw' `Current'
		require
			Valid: is_valid
		do
			Result := font_description.size
		end

	set_size(a_size:INTEGER)
			-- Assign `size' with the value of `a_size'
		require
			Valid: is_valid
		do
			font_description.set_size (a_size)
		ensure
			Is_Assign: size ~ a_size
		end

	width:INTEGER
			-- <Precursor>
			-- This feature is context wise, so it must be added to a {DIA_DIAGRAM} to work.
			-- Will return 0 if not.
		require else
			Valid: is_valid
		do
			if attached layout as la_layout then
				Result := la_layout.size_pixels.width
			else
				Result := 0
			end
		end

	height:INTEGER
			-- <Precursor>
			-- This feature is context wise, so it must be added to a {DIA_DIAGRAM} to work.
			-- Will return 0 if not.
		require else
			Valid: is_valid
		do
			if attached layout as la_layout then
				Result := la_layout.size_pixels.height
			else
				Result := 0
			end
		end

	is_valid:BOOLEAN
			-- `Current' can be used
		do
			Result := Precursor and attached layout
		end


	is_align_text_left:BOOLEAN
			-- The `text' of `Current' is align to the left
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				Result := not la_layout.is_justify_enabled and la_layout.is_alignment_left
			end
		end

	align_text_left
			-- align text of `Current' to the left
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				la_layout.disable_justify
				la_layout.set_alignment_left
			end
		ensure
			Is_Left_Set: is_align_text_left
			Is_Center_Unset: not is_align_text_center
			Is_Right_Unset: not is_align_text_right
			Is_Justified_Unset: not is_align_text_justified
		end

	is_align_text_center:BOOLEAN
			-- The `text' of `Current' is centered
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				Result := not la_layout.is_justify_enabled and la_layout.is_alignment_center
			end
		end

	align_text_center
			-- center text of `Current'
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				la_layout.disable_justify
				la_layout.set_alignment_center
			end
		ensure
			Is_Left_Unset: not is_align_text_left
			Is_Center_Set: is_align_text_center
			Is_Right_Unset: not is_align_text_right
			Is_Justified_Unset: not is_align_text_justified
		end

	is_align_text_right:BOOLEAN
			-- The `text' of `Current' is align to the right
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				Result := not la_layout.is_justify_enabled and la_layout.is_alignment_right
			end
		end

	align_text_right
			-- align text of `Current' to the right
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				la_layout.disable_justify
				la_layout.set_alignment_right
			end
		ensure
			Is_Left_Unset: not is_align_text_left
			Is_Center_Unset: not is_align_text_center
			Is_Right_Set: is_align_text_right
			Is_Justified_Unset: not is_align_text_justified
		end

	is_align_text_justified:BOOLEAN
			-- The `text' of `Current' is justified
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				Result := la_layout.is_justify_enabled
			end
		end

	align_text_justified
			-- justifie text of `Current'
		require
			Valid: is_valid
		do
			if attached layout as la_layout then
				la_layout.enable_justify
			end
		ensure
			Is_Left_Unset: not is_align_text_left
			Is_Center_Unset: not is_align_text_center
			Is_Right_Unset: not is_align_text_right
			Is_Justified_Set: is_align_text_justified
		end

feature {DIA_TEXT_BOX} -- Implementation

	layout:detachable PANGO_CAIRO_LAYOUT
			-- The {PANGO_LAYOUT} used to `draw' `Current'

feature {NONE} -- Implementation

	draw_stroke(a_context:CAIRO_CONTEXT)
			-- <Precursor>
		local
			l_x, l_y:INTEGER
		do
			if attached layout as la_layout then
				la_layout.set_font_description (font_description)
				l_x := x
				if is_align_horizontal_center then
					l_x := x - (width // 2)
				elseif is_align_horizontal_right then
					l_x :=x - width
				end
				l_y := y
				if is_align_vertical_center then
					l_y := y - (height // 2)
				elseif is_align_vertical_bottom then
					l_y :=y - height
				end
				a_context.move_to (l_x, l_y)
				la_layout.update_context
				la_layout.show
			end
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

feature {DIA_DIAGRAM, DIA_TEXT_BOX} -- Implementation

	is_align_horizontal_left:BOOLEAN
			-- `Current' is align horizonally to the left

	is_align_horizontal_center:BOOLEAN
			-- `Current' is centered horizonally

	is_align_horizontal_right:BOOLEAN
			-- `Current' is align horizonally to the right

	is_align_vertical_center:BOOLEAN
			-- `Current' is centered vertically

	is_align_vertical_bottom:BOOLEAN
			-- `Current' is align vertically to the bottom

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

	update_context
			-- <Precursor>
		do
			if attached diagram as la_diagram then
				if attached layout as la_layout then
					la_layout.set_cairo_context(la_diagram.context)
				else
					create layout.make (la_diagram.context)
				end
				align_text_left
			else
				layout := Void
			end
		end

invariant
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
	Align_Text_Valid:
					is_valid implies (
						(is_align_text_left or is_align_text_center or is_align_text_right or is_align_text_justified) and
						(is_align_text_left implies (not is_align_text_center and not is_align_text_right and not is_align_text_justified)) and
						(is_align_text_center implies (not is_align_text_left and not is_align_text_right and not is_align_text_justified)) and
						(is_align_text_right implies (not is_align_text_left and not is_align_text_center and not is_align_text_justified)) and
						(is_align_text_justified implies (not is_align_text_left and not is_align_text_center and not is_align_text_right))
					)

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
