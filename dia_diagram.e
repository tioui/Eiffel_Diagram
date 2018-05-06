note
	description: "Controler of a diagram"
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

class
	DIA_DIAGRAM

inherit
	DIA_FILLABLE
		rename
			fill_color as background_color,
			set_fill_color as set_background_color
		end
	DIA_DIMENSIONABLE
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make(a_width, a_height:INTEGER)
			-- Initialization of `Current' using `a_width' as `width' and `a_height' as `height'
		do
			default_create
			set_width (a_width)
			set_height (a_height)
			create {LINKED_LIST[DIA_ELEMENT]} elements_external.make
			create {LINKED_LIST[DIA_LINK]} links_external.make
			elements_external.compare_objects
			links_external.compare_objects
			set_background_color (1.0, 1.0, 1.0, 1.0)
		ensure
			Height_Assign: width ~ a_width
			Height_Assign: height ~ a_height
		end

feature -- Access

	draw(a_surface:CAIRO_SURFACE)
			-- Draw `Current' on `a_surface'
		local
			l_context:CAIRO_CONTEXT
		do
			create l_context.make (a_surface)
			l_context.set_source_rgba (background_color.red, background_color.green, background_color.blue, background_color.alpha)
			l_context.paint
			across elements_external as la_elements loop
				la_elements.item.draw (l_context)
			end
		end

	add_element(a_element:DIA_ELEMENT)
			-- Add `a_element' in `element'
		require
			Element_Not_Already_Added: not elements.has (a_element)
		do
			elements_external.extend (a_element)
		ensure
			Is_Added: elements.last ~ a_element
			Is_unique: elements.occurrences (a_element) = 1
		end

	move_to_top(a_element:DIA_ELEMENT)
			-- Move `a_element' to the top
		require
			Element_Exists: elements.has (a_element)
		do
			elements_external.prune_all (a_element)
			add_element (a_element)
		ensure
			Is_Added: elements.last ~ a_element
		end

	elements:LIST[DIA_ELEMENT]
			-- Every {DIA_ELEMENT} in `Current'
		do
			create {ARRAYED_LIST[DIA_ELEMENT]} Result.make (elements_external.count)
			Result.compare_objects
			Result.append (elements_external)
		end

	links:LIST[DIA_LINK]
			-- Every {DIA_LINK} in `Current'
		do
			create {ARRAYED_LIST[DIA_LINK]} Result.make (links_external.count)
			Result.compare_objects
			Result.append (links_external)
		end

feature {NONE} -- Implementation


	elements_external:LIST[DIA_ELEMENT]
			-- Internal representation of `elements'

	links_external:LIST[DIA_LINK]
			-- Internal representation of `links'

invariant
	Elements_Unique: across elements as la_elements all elements.occurrences (la_elements.item) = 1 end
end
