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
	DIA_MUTABLE_DIMENSIONABLE
		undefine
			default_create
		end

create
	make,
	make_from_image_surface

feature {NONE} -- Initialization

	make(a_surface:CAIRO_SURFACE; a_width, a_height:INTEGER)
			-- Initialization of `Current' using `a_surface' to initialize `context', `a_width' as `width' and `a_height' as `height'
		do
			make_with_context(create {CAIRO_CONTEXT}.make (a_surface), a_width, a_height)
		ensure
			Surface_Assign: context.surface ~ a_surface
			Height_Assign: width ~ a_width
			Height_Assign: height ~ a_height
		end

	make_from_image_surface(a_surface:CAIRO_SURFACE_IMAGE)
			-- Initialization of `Current' using `a_surface' to initialize `context', `width' and `height'
		do
			make(a_surface, a_surface.width, a_surface.height)
		ensure
			Surface_Assign: context.surface ~ a_surface
			Height_Assign: width ~ a_surface.width
			Height_Assign: height ~ a_surface.height
		end

	make_with_context(a_context:CAIRO_CONTEXT; a_width, a_height:INTEGER)
			-- Initialization of `Current' using `a_context' as `context', `a_width' as `width' and `a_height' as `height'
		do
			default_create
			context := a_context
			set_width (a_width)
			set_height (a_height)
			create {LINKED_LIST[DIA_ELEMENT]} elements_external.make
			create {LINKED_LIST[DIA_LINK]} links_external.make
			elements_external.compare_objects
			links_external.compare_objects
			set_background_color (1.0, 1.0, 1.0, 1.0)
		ensure
			Context_Assign: context ~ a_context
			Height_Assign: width ~ a_width
			Height_Assign: height ~ a_height
		end

feature -- Access

	has_error:BOOLEAN
			-- An error occured on the last operation
		do
			Result :=
					across elements_external as la_elements some la_elements.item.has_error end
				or
					across links_external as la_links some la_links.item.has_error end
		end

	draw
			-- Draw `Current' on `a_surface'
		require
			No_Error: not has_error
		do
			context.set_source_rgba (background_color.red, background_color.green, background_color.blue, background_color.alpha)
			context.paint
			across elements_external as la_elements loop
				la_elements.item.draw
			end
			across links_external as la_links loop
				la_links.item.draw
			end
			context.show_page
		end

	add_element(a_element:DIA_ELEMENT)
			-- Add `a_element' in `elements'
		require
			Element_Not_Already_Added: not elements.has (a_element)
		do
			a_element.set_diagram(Current)
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

	remove_element(a_element:DIA_ELEMENT)
			-- Remove `a_element' from `elements'
		require
			Element_Exists: elements.has (a_element)
		do
			a_element.set_diagram (Void)
			elements_external.prune_all (a_element)
		ensure
			Not_Exists: not elements.has (a_element)
		end

	elements:LIST[DIA_ELEMENT]
			-- Every {DIA_ELEMENT} in `Current'
		do
			create {ARRAYED_LIST[DIA_ELEMENT]} Result.make (elements_external.count)
			Result.compare_objects
			Result.append (elements_external)
		end

	add_link(a_link:DIA_LINK)
			-- Add `a_link' in `links'
		require
			Link_Not_Already_Added: not links.has (a_link)
		do
			a_link.set_diagram(Current)
			links_external.extend (a_link)
		ensure
			Is_Added: links.last ~ a_link
			Is_unique: links.occurrences (a_link) = 1
		end

	remove_links(a_link:DIA_LINK)
			-- Remove `a_links' from `links'
		require
			Link_Exists: links.has (a_link)
		do
			a_link.set_diagram(Void)
			links_external.prune_all (a_link)
		ensure
			Not_Exists: not links.has (a_link)
		end

	links:LIST[DIA_LINK]
			-- Every {DIA_LINK} in `Current'
		do
			create {ARRAYED_LIST[DIA_LINK]} Result.make (links_external.count)
			Result.compare_objects
			Result.append (links_external)
		end

	context:CAIRO_CONTEXT
			-- The {CAIRO_CONTEXT} of `Current'

feature {NONE} -- Implementation


	elements_external:LIST[DIA_ELEMENT]
			-- Internal representation of `elements'

	links_external:LIST[DIA_LINK]
			-- Internal representation of `links'

invariant
	Elements_Unique: across elements as la_elements all elements.occurrences (la_elements.item) = 1 end
	Elements_Diagram_valid: across elements as la_elements all la_elements.item.diagram ~ Current end
end
