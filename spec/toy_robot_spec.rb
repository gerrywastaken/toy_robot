require_relative 'spec_helper'

describe 'toy_robot', type: :feature do
  describe 'interface' do
    it 'can report when asked' do
      commands = <<~cmd.chomp
        PLACE 0,0,NORTH
        REPORT
      cmd

      expect(pipe_commands(commands)).to eql('0,0,NORTH')
    end

    it 'can be placed' do
      commands = <<~cmd.chomp
        PLACE 4,4,NORTH
        REPORT
      cmd

      expect(pipe_commands(commands)).to eql('4,4,NORTH')
    end

    it 'only reports when appropriate' do
      commands = <<~cmd.chomp
        PLACE 4,4,NORTH
      cmd

      expect(pipe_commands(commands)).to eql('')
    end

    it 'can not be placed in an invalid direction' do
      command_output_match "PLACE 0,0,MAGNETIC_NORTH\nREPORT",
                           'Error: invalid direction [MAGNETIC_NORTH]'
    end
  end

  describe 'provided specs' do
    describe 'example 1' do
      it 'reports a move' do
        pending 'Still to be implimented'

        commands = <<~cmd.chomp
          PLACE 0,0,NORTH
          MOVE
          REPORT
        cmd

        expect(pipe_commands(commands)).to eql('0,2,NORTH')
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

        expect(pipe_commands(commands)).to eql('0,0,WEST')
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

        expect(pipe_commands(commands)).to eql('3,3,NORTH')
      end
    end
  end

  private

  def pipe_commands(command_string)
    `echo '#{command_string}' | ./toy_robot`
  end

  def command_output_match_through(commands, expected_output)
    command_output = pipe_commands(commands).chomp
    expect(command_output).to eql(expected_output)
  end

  def command_output_match_fast(commands, expected_output)
    commands = commands.split("\n") if commands.respond_to?(:split)
    expect { main(commands) }.to output(expected_output + "\n").to_stdout
  end

  def command_output_match(commands, expected_output)
    if ENV['SPEC_FASTER'] == 'true'
      command_output_match_fast(commands, expected_output)
    else
      command_output_match_thorough(commands, expected_output)
    end
  end
end
