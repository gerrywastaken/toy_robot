# Handle robot movement
class Robot
  def self.build
    new
  end

  def initialize
  end

  def place(x_pos, y_pos, direction)
    @position = "#{x_pos},#{y_pos},#{direction.upcase}"
  end

  def report
    @position
  end
end
