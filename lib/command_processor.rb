require './lib/parser.rb'
require './lib/instructor.rb'

# Handles the transformation of user input to Instructor calls
class CommandProcessor
  def self.build(parser: Parser.new, instructor: Instructor.build, input: ARGF)
    new(parser, instructor, input)
  end

  def initialize(parser, instructor, input)
    @parser = parser
    @instructor = instructor
    @input = input
  end

  def run
    @input.each do |line|
      run_line(line)
    end
  end

  private

  def run_line(line)
    command, arguments = @parser.read(line).values_at(:command, :arguments)

    if arguments
      @instructor.send(command, *arguments.values)
    else
      @instructor.send(command)
    end
  rescue ParseError, OutsideBounds => exception
    puts exception.message
  end
end
