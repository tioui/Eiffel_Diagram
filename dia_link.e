note
	description: "Used to link two or more {DIA_OBJECT}"
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

class
	DIA_LINK

inherit
	DIA_OBJECT
		redefine
			default_create, draw
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
			-- Initialization of `Current'
		do
			Precursor {DIA_OBJECT}
			create {LINKED_LIST[DIA_ANCHOR_POINT]}corner_anchors.make
			create {DIA_ANCHOR_POINT}start_anchor.make (0,0)
			create {DIA_ANCHOR_POINT}end_anchor.make (0,0)
		end

	make(a_start_anchor, a_end_anchor:DIA_ANCHOR)
			-- Initialization of `Current' using `a_start_anchor' as `start_anchor' and
			-- `a_end_anchor' as `end_anchor'
		do
			default_create
			set_start_anchor (a_start_anchor)
			set_end_anchor (a_end_anchor)
		ensure
			Is_Start_Anchor_Assign: start_anchor ~ a_start_anchor
			Is_End_Anchor_Assign: end_anchor ~ a_end_anchor
		end

feature -- Access

	draw
			-- <Precursor>
		do
			Precursor
			draw_marker(start_marker)
			draw_marker(end_marker)
		end

	start_marker:detachable DIA_MARKER assign set_start_marker
			-- The {DIA_MARKER} to put at the start of `Current'

	set_start_marker(a_marker:detachable DIA_MARKER)
			-- Assign `start_marker' with the value of `a_marker'
		local
			l_start:TUPLE[x, y:INTEGER]
		do
			if attached a_marker as la_marker then
				l_start := after_start_position
				la_marker.set_link (Current, True, l_start.x, l_start.y, start_position.x, start_position.y)
			else
				if attached start_marker as la_marker then
					la_marker.unset_link
				end
			end
			start_marker := a_marker
		ensure
			Is_Assign: start_marker ~ a_marker
		end

	start_anchor:DIA_ANCHOR assign set_start_anchor
			-- The {DIA_ANCHOR} used to define `start_position'

	set_start_anchor(a_anchor:DIA_ANCHOR)
			-- Assign `start_anchor' with the value of `a_anchor'
		do
			start_anchor := a_anchor
		ensure
			Is_Assign: start_anchor ~ a_anchor
		end

	set_start_position(a_x, a_y:INTEGER)
			-- Assign `start_position' with the value of `a_x' and `a_y'
		do
			create {DIA_ANCHOR_POINT}start_anchor.make(a_x, a_y)
		ensure
			Is_Assign: start_position.x ~ a_x and start_position.y ~ a_y
		end

	start_position:TUPLE[x, y:INTEGER]
			-- The starting extremity of `Current'
		local
			l_x, l_y:INTEGER
		do
			l_x := end_anchor.x
			l_y := end_anchor.y
			if corner_anchors.count > 0 then
				l_x := corner_anchors.first.x
				l_y := corner_anchors.first.y
			end
			Result := start_anchor.anchor_point (l_x, l_y)
		end

	start_position_before_marker:TUPLE[x, y:INTEGER]
			-- The `start_position' when considaring the `start_marker'
		local
			l_gap:TUPLE[x, y:REAL_64]
			l_start_position:TUPLE[x, y:INTEGER]
		do
			if attached start_marker as la_marker then
				l_start_position := start_position
				l_gap := gap_dimension(la_marker.gap, l_start_position, after_start_position)
				Result := [(l_start_position.x - l_gap.x).rounded, (l_start_position.y - l_gap.y).rounded]
			else
				Result := start_position
			end
		end



	end_marker:detachable DIA_MARKER assign set_end_marker
			-- The {DIA_MARKER} to put at the end of `Current'

	set_end_marker(a_marker:detachable DIA_MARKER)
			-- Assign `end_marker' with the value of `a_marker'
		local
			l_start:TUPLE[x, y:INTEGER]
		do
			if attached a_marker as la_marker then
				l_start := before_end_position
				la_marker.set_link (Current, False, l_start.x, l_start.y, end_position.x, end_position.y)
			else
				if attached end_marker as la_marker then
					la_marker.unset_link
				end
			end
			end_marker := a_marker
		ensure
			Is_Assign: end_marker ~ a_marker
		end

	end_anchor:DIA_ANCHOR assign set_end_anchor
			-- The {DIA_ANCHOR} used to define `end_position'

	set_end_anchor(a_anchor:DIA_ANCHOR)
			-- Assign `end_anchor' with the value of `a_anchor'
		do
			end_anchor := a_anchor
		ensure
			Is_Assign: end_anchor ~ a_anchor
		end


	set_end_position(a_x, a_y:INTEGER)
			-- Assign `end_position' with the value of `a_x' and `a_y'
		do
			set_end_anchor(create {DIA_ANCHOR_POINT}.make(a_x, a_y))
		ensure
			Is_Assign: end_position.x ~ a_x and end_position.y ~ a_y
		end

	end_position:TUPLE[x, y:INTEGER]
			-- The ending extremity of `Current'
		local
			l_x, l_y:INTEGER
		do
			l_x := start_anchor.x
			l_y :=start_anchor.y
			if corner_anchors.count > 0 then
				l_x := corner_anchors.last.x
				l_y := corner_anchors.last.y
			end
			Result := end_anchor.anchor_point (l_x, l_y)
		end

	end_position_before_marker:TUPLE[x, y:INTEGER]
			-- The `end_position' when considaring the `end_marker'
		local
			l_gap:TUPLE[x, y:REAL_64]
			l_end_position:TUPLE[x, y:INTEGER]
		do
			if attached end_marker as la_marker then
				l_end_position := end_position
				l_gap := gap_dimension(la_marker.gap, l_end_position, before_end_position)
				Result := [(l_end_position.x - l_gap.x).rounded, (l_end_position.y - l_gap.y).rounded]
			else
				Result := end_position
			end
		end

	add_corner(a_x, a_y:INTEGER)
			-- Add a corner at `a_x',`a_y' to the end of `corner_anchors'
		do
			corner_anchors.extend (create {DIA_ANCHOR_POINT}.make (a_x, a_y))
		end


	corner_anchors:DYNAMIC_LIST[DIA_ANCHOR_POINT]
			-- The {DIA_ANCHOR_POINT} used for each `corners'
			-- Modifying this will change the `corners'

feature {NONE} -- Implementation

	gap_dimension(a_gap:REAL_64; a_position, a_before_position:TUPLE[x, y:INTEGER]):TUPLE[x, y:REAL_64]
			-- The dimension of the gap of length `a_gap'
		local
			l_hypotenuse:REAL_64
			l_x, l_y:INTEGER
		do
			l_x := a_position.x - a_before_position.x
			l_y := a_position.y - a_before_position.y
			l_hypotenuse := sqrt (l_x^2 + l_y^2)
			Result := [(l_x / l_hypotenuse) * a_gap, (l_y / l_hypotenuse) * a_gap]
		end

	after_start_position:TUPLE[x, y:INTEGER]
			-- The position of the second point (corner or anchor) of `Current'
		do
			if corner_anchors.is_empty then
				Result := end_position
			else
				Result := [corner_anchors.last.x, corner_anchors.last.y]
			end
		end

	before_end_position:TUPLE[x, y:INTEGER]
			-- The position of the second point (corner or anchor) before the end of `Current'
		do
			if corner_anchors.is_empty then
				Result := start_position
			else
				Result := [corner_anchors.first.x, corner_anchors.first.y]
			end
		end

	draw_stroke(a_context:CAIRO_CONTEXT)
			-- <Precursor>
		local
			l_position:TUPLE[x, y:INTEGER]
		do
			l_position := start_position_before_marker
			a_context.move_to (l_position.x, l_position.y)
			across
				corner_anchors as la_corners
			loop
				a_context.line_to (la_corners.item.x, la_corners.item.y)
			end
			l_position := end_position_before_marker
			a_context.line_to (l_position.x, l_position.y)
		end

	draw_marker(a_marker:detachable DIA_MARKER)
			-- draw `a_marker' if it exists
		do

			if attached a_marker as la_marker then
				if not attached la_marker.diagram then
					la_marker.set_diagram (diagram)
				end
				la_marker.draw
			end
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
