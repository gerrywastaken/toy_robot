# A simple class for checking if coordinates given fall within those dimensions.
# This could also be used to hold details about objects on each table.
class Table
  def initialize(width = 5, height = 5)
    @width = width
    @height = height
  end

  def valid_position?(x_pos, y_pos)
    last_column = @width - 1
    last_row = @height - 1
    # (0..last_column).cover?(x_pos) && (0..last_row).cover?(y_pos)
    x_pos.between?(0, last_column) && y_pos.between?(0, last_row)
  end
end
