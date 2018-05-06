note
	description: "Object that have a dimension."
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

deferred class
	DIA_DIMENSIONABLE

feature --Access

	width:INTEGER assign set_width
			-- Horizontal dimension of `Current'

	set_width(a_width:like width)
			-- Assign `a_width' to `width'
		do
			width := a_width
		ensure
			Is_Assign: width ~ a_width
		end

	height:INTEGER assign set_height
			-- Vertical dimension of `Current'

	set_height(a_height:like height)
			-- Assign `a_height' to `height'
		do
			height := a_height
		ensure
			Is_Assign: height ~ a_height
		end

end
