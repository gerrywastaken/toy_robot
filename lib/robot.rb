# Handle robot movement
class Robot
  def self.build
    new
  end

  def place(x_pos, y_pos, direction)
    ensure_valid_direction(direction)
    @x_pos = x_pos
    @y_pos = y_pos
    @direction = direction
    true
  end

  def placed?
    @direction
  end

  # Moves the robot one step in it's current direction.
  # This takes a block. It puts it's life in your hands by checking this block
  # to see if it's next move will be a safe one. If you lie, it will take you
  # at your word and the oil will be on your hands!
  def move(&_is_valid_position)
    if placed?
      new_position = next_move
      if yield(new_position)
        @x_pos, @y_pos = new_position
      else
        raise InvalidMove, "Error: Invalid move #{new_position}"
      end
    end
  end

  def report
    "#{@x_pos},#{@y_pos},#{@direction.upcase}" if placed?
  end

  def self.valid_directions
    [:north, :east, :south, :west]
  end

  protected

  # Calculates the new postion one square in the direction the robot is facing.
  def next_move
    case @direction
    when :north
      [@x_pos, @y_pos + 1]
    when :south
      [@x_pos, @y_pos - 1]
    when :east
      [@x_pos + 1, @y_pos]
    when :west
      [@x_pos - 1, @y_pos]
    end
  end

  # This should be caught by a parsing stage. This is just a backup check in
  # case something goes wrong.
  def ensure_valid_direction(direction)
    raise InvalidDirextion unless
      self.class.valid_directions.include?(direction)
  end
end
