# Dispatches recieved commands to appropriate parts of the system.
class Instructor
  def self.build(width: 5, height: 5)
    new(width, height)
  end

  def initialize(width, height)
    @width = width
    @height = height
  end

  def place(x_pos, y_pos, direction)
    @position = "#{x_pos},#{y_pos},#{direction.upcase}"
  end

  def move; end

  def left; end

  def right; end

  def report
    print @position
  end
end
