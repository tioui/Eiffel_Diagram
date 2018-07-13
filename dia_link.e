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
			default_create
		end

create
	default_create,
	make
feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			Precursor
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

	start_marker:detachable DIA_MARKER assign set_start_marker
			-- The {DIA_MARKER} to put at the start of `Current'

	set_start_marker(a_marker:detachable DIA_MARKER)
			-- Assign `start_marker' with the value of `a_marker'
		do
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



	end_marker:detachable DIA_MARKER assign set_end_marker
			-- The {DIA_MARKER} to put at the end of `Current'

	set_end_marker(a_marker:detachable DIA_MARKER)
			-- Assign `end_marker' with the value of `a_marker'
		do
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

	add_corner(a_x, a_y:INTEGER)
			-- Add a corner at `a_x',`a_y' to the end of `corner_anchors'
		do
			corner_anchors.extend (create {DIA_ANCHOR_POINT}.make (a_x, a_y))
		end


	corner_anchors:DYNAMIC_LIST[DIA_ANCHOR_POINT]
			-- The {DIA_ANCHOR_POINT} used for each `corners'
			-- Modifying this will change the `corners'

feature {NONE} -- Implementation

	draw_stroke(a_context:CAIRO_CONTEXT)
			-- <Precursor>
		local
			l_position:TUPLE[x, y:INTEGER]
		do
			l_position := start_position
			a_context.move_to (l_position.x, l_position.y)
			across
				corner_anchors as la_corners
			loop
				a_context.line_to (la_corners.item.x, la_corners.item.y)
			end
			l_position := end_position
			a_context.line_to (l_position.x, l_position.y)
		end

end
