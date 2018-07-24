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

invariant

note
	copywrite: "Copyright (c) 2018, Louis Marchand"
	license: "[
				Permission is hereby granted, free of charge, to any person obtaining a
				copy of this software and associated documentation files (the "Software"),
				to deal in the Software without restriction, including without limitation
				the rights to use, copy, modify, merge, publish, distribute, sublicense,
				and/or sell copies of the Software, and to permit persons to whom the
				Software is furnished to do so, subject to the following conditions:

				The above copyright notice and this permission notice shall be included
				in all copies or substantial portions of the Software.

				THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
				OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
				FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
				THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
				LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
				FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
				DEALINGS IN THE SOFTWARE.
		]"

end
