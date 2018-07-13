note
	description: "Object that have a dimension."
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

deferred class
	DIA_MUTABLE_DIMENSIONABLE

inherit
	DIA_DIMENSIONABLE

feature --Access

	width:INTEGER assign set_width
			-- <Precursor>
		do
			Result := internal_width
		end

	set_width(a_width:like width)
			-- Assign `a_width' to `width'
		do
			internal_width := a_width
		ensure
			Is_Assign: width ~ a_width
		end

	height:INTEGER assign set_height
			-- <Precursor>
		do
			Result := internal_height
		end

	set_height(a_height:like height)
			-- Assign `a_height' to `height'
		do
			internal_height := a_height
		ensure
			Is_Assign: height ~ a_height
		end

feature {NONE} -- Implementation

	internal_width:INTEGER
			-- Internal representation of `width'

	internal_height:INTEGER
			-- Internal representation of `height'
end
