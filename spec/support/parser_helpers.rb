# Helper utility methods to help with writing tests
module SpecHelpers
  # Generates expected output of Parser.read
  def generate_expected(command_string)
    command, argument_string = command_string.split

    {
      command: command.downcase.to_sym,
      arguments: arguments_hash(argument_string)
    }
  end

  private

  # Generates arguments part of Parser.read output
  def arguments_hash(argument_string)
    return {} unless argument_string
    arguments = argument_string.split(',')
    {
      x_pos: arguments[0].to_i,
      y_pos: arguments[1].to_i,
      direction: arguments[2].downcase.to_sym
    }
  end
end
