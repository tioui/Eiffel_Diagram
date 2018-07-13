note
	description: "Summary description for {DIA_MARKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIA_MARKER

inherit
	DIA_OBJECT
		redefine
			is_valid
		end

feature -- Access

	link:detachable DIA_LINK

	is_valid:BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and attached link
		end

feature {DIA_LINK} -- Implementation

	source_x:INTEGER
			-- Horizontal position of the source point

	source_y:INTEGER
			-- Vertical position of the source point

	destination_x:INTEGER
			-- Horizontal position of the destination point

	destination_y:INTEGER
			-- Vertical position of the destination point

	set_link(a_link:DIA_LINK; a_source_x, a_source_y, a_destination_x, a_destination_y:INTEGER)
			--
		do
			link := a_link
			source_x := a_source_x
			source_y := a_source_y
			destination_x := a_destination_x
			destination_y := a_destination_y
			update_coordinates
		ensure
			Is_Link_Assing: link ~ a_link
			Is_Source_Assign: source_x ~ a_source_x and source_y ~ a_source_y
			Is_Destination_Assign: destination_x ~ a_destination_x and destination_y ~ a_destination_y
		end

	unset_link
			--
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

--	draw_stroke(a_context:CAIRO_CONTEXT)
--			-- <Precursor>
--		do

--		end

end
