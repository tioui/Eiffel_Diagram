note
	description: "Summary description for {DIA_DIMENSIONABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIA_DIMENSIONABLE



feature -- Access

	width:INTEGER
			-- Horizontal dimension of `Current'
		deferred
		end

	height:INTEGER
			-- Vertical dimension of `Current'
		deferred
		end

end
