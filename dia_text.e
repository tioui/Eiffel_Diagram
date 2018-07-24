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
