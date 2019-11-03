require 'forwardable'
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
      self
    else
      raise OutsideBounds,
            "Error: coordinates are not on the table [#{x_pos},#{y_pos}]"
    end
  end

  def left
    @robot.left
    self
  end

  def right
    @robot.right
    self
  end

  def move
    @robot.move { |x_pos, y_pos| @platform.valid_position?(x_pos, y_pos) }
    self
  rescue InvalidMove => e
    puts e.message
  end

  def report
    report = @robot.report
    puts report if report
  end
end
