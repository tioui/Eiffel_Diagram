note
	description: "Object that have a position"
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

deferred class
	DIA_POSITIONABLE


feature -- Access

	x:INTEGER assign set_x
			-- Horizontal position of `Current'

	set_x(a_x:like x)
			-- Assign `a_x' to `x'
		do
			x := a_x
		ensure
			Is_Assign: x ~ a_x
		end

	y:INTEGER assign set_y
			-- Vertical position of `Current'

	set_y(a_y:like y)
			-- Assign `a_y' to `y'
		do
			y := a_y
		ensure
			Is_Assign: y ~ a_y
		end
end
