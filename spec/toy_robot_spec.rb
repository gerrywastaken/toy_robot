require_relative 'spec_helper'

describe 'toy_robot', type: :feature do
  describe 'interface' do
    it 'can report when asked' do
      commands = <<~cmd.chomp
        PLACE 0,0,NORTH
        REPORT
      cmd

      command_output_match(commands, '0,0,NORTH')
    end

    it 'can be placed' do
      commands = <<~cmd.chomp
        PLACE 4,4,NORTH
        REPORT
      cmd

      command_output_match(commands, '4,4,NORTH')
    end

    it 'only reports when appropriate' do
      commands = <<~cmd.chomp
        PLACE 4,4,NORTH
      cmd

      command_output_match(commands, '')
    end

    it 'can not be placed in an invalid direction' do
      command_output_match "PLACE 0,0,MAGNETIC_NORTH\nREPORT",
                           'Error: invalid direction [MAGNETIC_NORTH]'
    end

    it 'will not perform action if command is invalid' do
      command_output_match 'PACE 0,0,NORTH', 'Error: invalid command [PACE]'
    end

    describe 'will not be placed off the table when' do
      it 'recieves a negative column' do
        error = 'Error: coordinates are not on the table [-1,0]'
        command_output_match "PLACE -1,0,NORTH\nREPORT", error
      end

      it 'recieves a negative row' do
        error = 'Error: coordinates are not on the table [0,-1]'
        command_output_match "PLACE 0,-1,NORTH\nREPORT", error
      end

      it 'recieves to high of a column' do
        error = 'Error: coordinates are not on the table [5,0]'
        command_output_match "PLACE 5,0,NORTH\nREPORT", error
      end

      it 'recieves too high of a row' do
        error = 'Error: coordinates are not on the table [0,5]'
        command_output_match "PLACE 0,5,NORTH\nREPORT", error
      end
    end
  end

  describe 'provided specs' do
    describe 'example 1' do
      it 'reports a move' do
        commands = <<~cmd.chomp
          PLACE 0,0,NORTH
          MOVE
          REPORT
        cmd

        command_output_match(commands, '0,1,NORTH')
      end
    end

    describe 'example 2' do
      it 'reports a left turn' do
        pending 'Still to be implimented'

        commands = <<~cmd.chomp
          PLACE 0,0,NORTH
          LEFT
          REPORT
        cmd

        command_output_match(commands, '0,0,WEST')
      end
    end

    describe 'example 3' do
      it 'reports a move and turn combination' do
        pending 'Still to be implimented'

        commands = <<~cmd.chomp
          PLACE 1,2,EAST
          MOVE
          MOVE
          LEFT
          MOVE
          REPORT
        cmd

        command_output_match(commands, '3,3,NORTH')
      end
    end
  end

  private

  # Sends a command to our program via piped standard imput and returns it's
  # output
  def pipe_commands(command_string)
    `echo '#{command_string}' | ./toy_robot`
  end

  # Pipe commands to our toy robot program for slow but realistic testing
  def command_output_match_thorough(commands, expected_output)
    command_output = pipe_commands(commands)
    expected_output += "\n" if !expected_output.empty?
    expect(command_output).to eql(expected_output)
  end

  # Pipe commands directly to the command processor for faster but less
  # realistic tests
  def command_output_match_fast(commands, expected_output)
    commands = commands.split("\n") if commands.respond_to?(:split)
    command_processor = CommandProcessor.build(input: commands)
    expected_output += "\n" if !expected_output.empty?
    expect { command_processor.run }.to output(expected_output).to_stdout
  end

  # Checks the output of a piped command against an expectation
  def command_output_match(commands, expected_output)
    if ENV['SPEC_FASTER'] == 'true'
      command_output_match_fast(commands, expected_output)
    else
      command_output_match_thorough(commands, expected_output)
    end
  end
end
