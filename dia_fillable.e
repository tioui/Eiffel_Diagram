note
	description: "Object that can be fill with color."
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

deferred class
	DIA_FILLABLE

inherit
	ANY
		redefine
			default_create
		end


feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			Precursor
			set_fill_color (1.0, 1.0, 1.0, 0.0)
		end

feature -- Access

	fill_color:TUPLE[red, green, blue, alpha:REAL_64]
			-- The color of the inside of `Current' (values between 0 and 1).

	set_fill_color(a_red, a_green, a_blue, a_alpha:REAL_64)
			-- Assign `fill_color' with the value of `a_red', `a_green', `a_blue' and `a_alpha'
		require
			Red_Valid: a_red >= 0 and a_red <= 1
			Green_Valid: a_green >= 0 and a_green <= 1
			Blue_Valid: a_blue >= 0 and a_blue <= 1
			Alpha_Valid: a_alpha >= 0 and a_alpha <= 1
		do
			fill_color := [a_red, a_green, a_blue, a_alpha]
		ensure
			Is_Red_Assign: fill_color.red ~ a_red
			Is_Green_Assign: fill_color.green ~ a_green
			Is_Blue_Assign: fill_color.blue ~ a_blue
			Is_Alpha_Assign: fill_color.alpha ~ a_alpha
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
