note
	description: "A text element in a diagram"
	author: "Louis Marchand"
	date: "Sun, 08 Jul 2018 20:55:11 +0000"
	revision: "0.1"

class
	DIA_TEXT

inherit
	DIA_TEXT_FIXED
		export
			{ANY} is_align_horizontal_left, is_align_horizontal_center, is_align_horizontal_right,
					is_align_vertical_center, is_align_vertical_bottom, is_align_vertical_top,
					align_vertical_top, align_vertical_center, align_vertical_bottom,
					align_horizontal_left, align_horizontal_center, align_horizontal_right, set_x, set_y
		end

create
	make

end
