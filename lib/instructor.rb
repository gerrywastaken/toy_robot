require './lib/table'

# Dispatches recieved commands to appropriate parts of the system.
class Instructor
  def self.build(width: 5, height: 5)
    platform = Table.new(width, height)
    new(platform)
  end

  def initialize(platform)
    @platform = platform
  end

  def place(x_pos, y_pos, direction)
    if @platform.valid_position?(x_pos, y_pos)
      @position = "#{x_pos},#{y_pos},#{direction.upcase}"
    else
      raise OutsideBounds,
            "Error: coordinates are not on the table [#{x_pos},#{y_pos}]"
    end
  end

  def move; end

  def left; end

  def right; end

  def report
    print @position
  end
end
