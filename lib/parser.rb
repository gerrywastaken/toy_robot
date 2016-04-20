require_relative 'exceptions'

# Takes a string and turns it into a toy_robot command and arguments
class Parser
  def read(input_line)
    parse(input_line)
    @command, @arguments = split(input_line)
    {
      command: command,
      arguments: arguments_hash
    }
  rescue ArgumentError, TypeError
    # Accounts for non numeric position strings such as '' or 'foo'
    err = "Error: invalid coordinates [#{@arguments[0]},#{@arguments[1]}]"
    raise ParseError, err
  end

  private

  attr_reader :arguments

  def arguments_hash
    if command == :place
      {
        x_pos: x_pos,
        y_pos: y_pos,
        direction: direction
      }
    end
  end

  def valid_commands
    %w(PLACE LEFT RIGHT MOVE REPORT)
  end

  def command
    if valid_commands.include?(@command)
      @command.downcase.to_sym
    else
      raise ParseError, "Error: invalid command [#{@command}]"
    end
  end

  def x_pos
    Integer(arguments[0])
  end

  def y_pos
    Integer(arguments[1])
  end

  def valid_directions
    %w(WEST NORTH EAST SOUTH)
  end

  def direction
    direction = arguments[2]
    if valid_directions.include?(direction)
      direction.downcase.to_sym
    else
      raise ParseError, "Error: invalid direction [#{direction}]"
    end
  end

  def parse(input_line)
    command = {} # reset any previous commands
    command[:name], command[:x_pos], command[:y_pos], command[:facing] =
      split(input_line)
  end

  def split(input_line)
    command, arguments = input_line.split
    arguments = String(arguments).split(',')
    [command, arguments]
  end
end
