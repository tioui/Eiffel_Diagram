note
	description: "An element of a diagram"
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

deferred class
	DIA_ELEMENT

inherit
	DIA_OBJECT
	DIA_DIMENSIONABLE
		undefine
			default_create
		end
	DIA_MUTABLE_POSITIONABLE
		undefine
			default_create
		end

end
