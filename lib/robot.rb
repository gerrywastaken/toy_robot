require 'circular_list'

# Handle robot movement
class Robot
  def self.build
    new(CircularList::List.new(valid_directions))
  end

  def initialize(direction_helper)
    @direction_helper = direction_helper
  end

  def place(x_pos, y_pos, direction)
    ensure_valid_direction(direction)
    @x_pos = x_pos
    @y_pos = y_pos
    @direction = direction
    self
  end

  def placed?
    @direction
  end

  # Moves the robot one step in it's current direction.
  # This takes a block. It puts it's life in your hands by checking this block
  # to see if it's next move will be a safe one. If you lie, it will take you
  # at your word and the oil will be on your hands!
  def move(&_is_valid_position)
    return unless placed?

    new_position = next_move
    if yield(new_position)
      @x_pos, @y_pos = new_position
    else
      raise InvalidMove, "Error: Invalid move #{new_position}"
    end
    self
  end

  def report
    return unless placed?
    "#{@x_pos},#{@y_pos},#{@direction.upcase}"
  end

  def left
    return unless placed?
    @direction = @direction_helper.fetch_before(@direction)
    self
  end

  def right
    return unless placed?
    @direction = @direction_helper.fetch_after(@direction)
    self
  end

  def self.valid_directions
    # The order of this list matters. Moving to the next index in order should
    # be the same as turning right. This is used in a circular list, so the
    # first element should also be to the right of the last element.
    [:north, :east, :south, :west]
  end

  protected

  # Calculates the new postion one square in the direction the robot is facing.
  def next_move
    case @direction
    when :north then [@x_pos, @y_pos + 1]
    when :south then [@x_pos, @y_pos - 1]
    when :east  then [@x_pos + 1, @y_pos]
    when :west  then [@x_pos - 1, @y_pos]
    end
  end

  # This should be caught by a parsing stage. This is just a backup check in
  # case something goes wrong.
  def ensure_valid_direction(direction)
    raise InvalidDirextion unless
      self.class.valid_directions.include?(direction)
  end
end
