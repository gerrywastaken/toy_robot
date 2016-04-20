require 'spec_helper'

shared_examples 'parses' do |command_string|
  context command_string do
    it 'parses' do
      command_hash = generate_expected(command_string)
      expect(parser.read(command_string)).to eql(command_hash)
    end
  end
end

shared_examples 'errors' do |command_string, error_string|
  context command_string do
    it 'errors' do
      expect { parser.read(command_string) }
        .to raise_error(ParseError, "Error: invalid #{error_string}")
    end
  end
end

describe Parser do
  subject(:parser) { described_class.new }

  context 'valid arguments' do
    include_examples 'parses', 'PLACE -1,0,NORTH'
    include_examples 'parses', 'PLACE 1,2,WEST'
    include_examples 'parses', 'PLACE 0,4,EAST'
    include_examples 'parses', 'PLACE 3,5,SOUTH'
    include_examples 'parses', 'MOVE'
    include_examples 'parses', 'LEFT'
    include_examples 'parses', 'RIGHT'
    include_examples 'parses', 'REPORT'
  end

  context 'invalid arguments' do
    include_examples 'errors', 'PLACE bar,0,NORTH', 'coordinates [bar,0]'
    include_examples 'errors', 'PLACE 0,foo,NORTH', 'coordinates [0,foo]'
    include_examples 'errors', 'PLACE ,0,NORTH', 'coordinates [,0]'
    include_examples 'errors', 'PLACE 0,,NORTH', 'coordinates [0,]'
    include_examples 'errors', 'PLACE ', 'coordinates [,]'
    include_examples 'errors', 'PLACE 1,2,3', 'direction [3]'
  end

  context 'invalid command' do
    include_examples 'errors', 'FOOBAR', 'command [FOOBAR]'
  end

  it 'can be called multiple times' do
    parser.read('PLACE 0,0,NORTH')
    command_string = 'REPORT'
    command_hash = generate_expected(command_string)
    expect(parser.read(command_string)).to eql(command_hash)
  end
end
