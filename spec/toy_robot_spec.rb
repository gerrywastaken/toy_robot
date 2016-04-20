require_relative 'spec_helper'

describe 'toy_robot provided specs', type: :feature do
  def pipe_commands(command_string)
    `echo '#{command_string}' | ./toy_robot`
  end

  describe 'example 1' do
    it 'reports a move' do
      pending 'Still to be implimented'

      commands = <<~cmd
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

      commands = <<~cmd
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

      commands = <<~cmd
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
