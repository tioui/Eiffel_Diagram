note
	description: "Object that have a position"
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

deferred class
	DIA_POSITIONABLE

feature -- Access

	x:INTEGER
			-- Horizontal position of `Current'
		deferred
		end

	y:INTEGER
			-- Vertical position of `Current'
		deferred
		end
		
end
