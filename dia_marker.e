note
	description: "A marker at the extremity of a {DIA_LINK}."
	author: "Louis Marchand"
	date: "Tue, 24 Jul 2018 13:45:38 +0000"
	revision: "0.1"

deferred class
	DIA_MARKER

inherit
	DIA_OBJECT
		export
			{DIA_LINK} set_diagram
		redefine
			is_valid
		end
	DIA_MUTABLE_DIMENSIONABLE
		undefine
			default_create
		redefine
			set_width, set_height
		end

feature -- Access

	set_width(a_width:INTEGER)
			-- <Precursor>
		do
			if a_width /= width then
				Precursor(a_width)
				update_coordinates
			end
		end

	set_height(a_height:INTEGER)
			-- <Precursor>
		do
			if a_height /= height then
				Precursor(a_height)
				update_coordinates
			end
		end

	link:detachable DIA_LINK
		-- The {DIA_LINK} that `Current' is attached to

	is_valid:BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and attached link
		end

feature {DIA_LINK} -- Implementation

	gap:REAL_64
			-- The distance that `Current' remove from the extremity of `link'
		deferred
		end

	source_x:INTEGER
			-- Horizontal position of the source point

	source_y:INTEGER
			-- Vertical position of the source point

	destination_x:INTEGER
			-- Horizontal position of the destination point

	destination_y:INTEGER
			-- Vertical position of the destination point

	is_start:BOOLEAN
			-- `destination_x' and `destination_y' correspond to the start of the `link'

	set_link(a_link:DIA_LINK; a_start:BOOLEAN; a_source_x, a_source_y, a_destination_x, a_destination_y:INTEGER)
			-- Assign `link' with the value of `a_link' and also assign `a_source_x' to `source_x',
			-- `a_source_y' to `source_y', `a_destination_x' to `destination_x' and `a_destination_y'
			-- to `destination_y'. It `a_start' is `True', then `Current' is at the start of the `link';
			-- `False' means at the end.
		do
			link := a_link
			is_start := a_start
			source_x := a_source_x
			source_y := a_source_y
			destination_x := a_destination_x
			destination_y := a_destination_y
			update_coordinates
			set_stroke_color (a_link.stroke_color.red, a_link.stroke_color.green, a_link.stroke_color.blue, a_link.stroke_color.alpha)
			set_fill_color (a_link.stroke_color.red, a_link.stroke_color.green, a_link.stroke_color.blue, a_link.stroke_color.alpha)
		ensure
			Is_Link_Assing: link ~ a_link
			Is_Source_Assign: source_x ~ a_source_x and source_y ~ a_source_y
			Is_Destination_Assign: destination_x ~ a_destination_x and destination_y ~ a_destination_y
		end

	unset_link
			-- Detached `link' from `Current'
		do
			link := Void
		ensure
			Link_Voided: not attached link
		end



feature {NONE} -- Implementation

	update_coordinates
			-- Update the coordinates used to `draw' `Current'
		deferred
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
