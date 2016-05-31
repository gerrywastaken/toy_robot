# A simple class for checking if coordinates given fall within those dimensions.
# This could also be used to hold details about objects on each table.
class Table
  def initialize(width = 5, height = 5)
    @width = width
    @height = height
  end

  # Determines if the given position still on the table?
  def valid_position?(x_pos, y_pos)
    (0...@width).cover?(x_pos) && (0...@height).cover?(y_pos)
  end
end
