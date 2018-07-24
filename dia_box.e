note
	description: "A box {DIA_ELEMENT}"
	author: "Louis Marchand"
	date: "Sun, 06 May 2018 23:30:56 +0000"
	revision: "0.1"

class
	DIA_BOX

inherit
	DIA_ELEMENT
	DIA_MUTABLE_DIMENSIONABLE
		undefine
			default_create
		end
	DOUBLE_MATH
		export
			{NONE} all
		undefine
			default_create
		end
	DIA_ANCHOR
		undefine
			default_create
		end


feature {DIA_LINK} -- Implementation

	anchor_point(a_source_x, a_source_y:INTEGER):TUPLE[x, y:INTEGER]
			-- <Precursor>
		do
			Result := anchor_point_with_height(a_source_x, a_source_y, height)
		end

feature {NONE} -- Implementation

	anchor_point_with_height(a_source_x, a_source_y, a_height:INTEGER):TUPLE[x, y:INTEGER]
			-- The position of the point where the DIA_LINK should end
			-- consideraing that the DIA_LINK start at `a_source_x`, `a_source_y`.
			-- Used `a_height' as `height'
		local
			l_distance:REAL_64
			l_source:TUPLE[x, y:REAL_64]
			l_result:TUPLE[point:detachable TUPLE[x, y:REAL_64]; distance:REAL_64]
			l_center:TUPLE[x, y:INTEGER]
		do
			l_center := [x + (width // 2), y + (a_height // 2)]
			l_source := [a_source_x.to_double, a_source_y.to_double]
			l_distance := {REAL_64}.positive_infinity
			l_result := [Void, {REAL_64}.positive_infinity]
			l_result := validate_point(
								l_result,
								find_intersect([x, y, x + width, y], [a_source_x, a_source_y, l_center.x, l_center.y]),
								l_source
							)
			l_result := validate_point(
								l_result,
								find_intersect([x, y, x, y + a_height], [a_source_x, a_source_y, l_center.x, l_center.y]),
								l_source
							)
			l_result := validate_point(
								l_result,
								find_intersect([x + width, y, x + width, y + a_height], [a_source_x, a_source_y, l_center.x, l_center.y]),
								l_source
							)
			l_result := validate_point(
								l_result,
								find_intersect([x, y + a_height, x + width, y + a_height], [a_source_x, a_source_y, l_center.x, l_center.y]),
								l_source
							)
			if attached l_result.point as la_point then
				Result := [la_point.x.rounded, la_point.y.rounded]
			else
				Result := [l_center.x, l_center.y]
			end
		end

	validate_point(
				a_old_point: TUPLE[point:detachable TUPLE[x, y:REAL_64]; distance:REAL_64];
				a_new_point:detachable TUPLE[x, y:REAL_64];
				a_source:TUPLE[x, y:REAL_64]
			):TUPLE[old_point:detachable TUPLE[x, y:REAL_64]; distance:REAL_64]
				-- Find the shorter distance between `a_old_point' and `a_source' or between
				-- `a_new_point' and `a_source'. Return the point and the distance
		local
			l_distance:REAL_64
		do
			Result := a_old_point
			if attached a_new_point as la_point then
				l_distance := (a_source.x - la_point.x).abs + (a_source.y - la_point.y).abs
				if l_distance < a_old_point.distance then
					Result := [la_point, l_distance]
				end
			end

		end

	find_intersect(a_line_1, a_line_2:TUPLE[x1, y1, x2, y2:INTEGER]):detachable TUPLE[x, y:REAL_64]
			-- Find the intersection between the two line segments `a_line_1' and `a_line_2', if any.
		local
			l_delta_x_1, l_delta_x_2, l_delta_y_1, l_delta_y_2, l_determinant, l_det_line_1, l_det_line_2, l_x, l_y:REAL_64
		do
			l_delta_x_1 := a_line_1.x1 - a_line_1.x2
			l_delta_y_1 := a_line_1.y1 - a_line_1.y2
			l_delta_x_2 := a_line_2.x1 - a_line_2.x2
			l_delta_y_2 := a_line_2.y1 - a_line_2.y2
			l_determinant := l_delta_x_1 * l_delta_y_2 - l_delta_x_2 * l_delta_y_1
			if l_determinant /= 0.0 then
				l_det_line_1 := a_line_1.x1 * a_line_1.y2 - a_line_1.y1 * a_line_1.x2
				l_det_line_2 := a_line_2.x1 * a_line_2.y2 - a_line_2.y1 * a_line_2.x2
				l_x := (l_det_line_1 * l_delta_x_2 - l_det_line_2 * l_delta_x_1) / l_determinant
				l_y := (l_det_line_1 * l_delta_y_2 - l_det_line_2 * l_delta_y_1) / l_determinant
				if
					l_x >= a_line_1.x1.min (a_line_1.x2) and l_x <= a_line_1.x1.max (a_line_1.x2) and
					l_y >= a_line_1.y1.min (a_line_1.y2) and l_y <= a_line_1.y1.max (a_line_1.y2) and
					l_x >= a_line_2.x1.min (a_line_2.x2) and l_x <= a_line_2.x1.max (a_line_2.x2) and
					l_y >= a_line_2.y1.min (a_line_2.y2) and l_y <= a_line_2.y1.max (a_line_2.y2)
				then
					Result := [l_x, l_y]
				end
			end
		end

	draw_stroke(a_context:CAIRO_CONTEXT)
			-- <Precursor>
		do
			a_context.move_to (x, y)
			a_context.line_to (x + width, y)
			a_context.line_to (x + width, y + height)
			a_context.line_to (x, y + height)
			a_context.line_to (x, y)
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
