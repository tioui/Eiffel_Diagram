note
	description: "A {DIA_ANCHOR} that represent only a point"
	author: "Louis Marchand"
	date: "Tue, 24 Jul 2018 13:45:38 +0000"
	revision: "0.1"

class
	DIA_ANCHOR_POINT

inherit
	DIA_ANCHOR
		redefine
			default_create
		end
	DIA_MUTABLE_POSITIONABLE
		redefine
			default_create
		end
create
	default_create,
	make

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			set_x(0)
			set_y(0)
		end

	make(a_x, a_y:INTEGER)
			-- Initialization of `Current' using `a_x' as `x' and `a_y' as `y'
		do
			set_x(a_x)
			set_y(a_y)
		ensure
			Is_X_Assing: x ~ a_x
			Is_Y_Assing: y ~ a_y
		end
feature {DIA_LINK} -- Implementation

	anchor_point(a_source_x, a_source_y:INTEGER):TUPLE[x, y:INTEGER]
			-- <Precursor>
		do
			Result := [x, y]
		end

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
