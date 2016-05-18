require './lib/table'
require './lib/robot'

# Dispatches recieved commands to appropriate parts of the system.
class Instructor
  def self.build(width: 5, height: 5)
    platform = Table.new(width, height)
    robot = Robot.build
    new(platform, robot)
  end

  def initialize(platform, robot)
    @platform = platform
    @robot = robot
  end

  def place(x_pos, y_pos, direction)
    if @platform.valid_position?(x_pos, y_pos)
      @robot.place(x_pos, y_pos, direction)
    else
      raise OutsideBounds,
            "Error: coordinates are not on the table [#{x_pos},#{y_pos}]"
    end
  end

  def move; end

  def left; end

  def right; end

  def report
    print @robot.report
  end
end
