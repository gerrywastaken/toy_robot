require 'spec_helper'

shared_examples 'out_of_bounds' do |x_pos, y_pos|
  it "does not allow placing at #{x_pos}, #{y_pos}" do
    expect { subject.place(x_pos, y_pos, :north) }
      .to raise_error(
        OutsideBounds,
        "Error: coordinates are not on the table [#{x_pos},#{y_pos}]"
      )
  end
end

shared_examples 'within_bounds' do |x_pos, y_pos|
  it "allows placing at #{x_pos}, #{y_pos}" do
    subject.place(x_pos, y_pos, :north)
    expect { subject.report }.to output("#{x_pos},#{y_pos},NORTH\n").to_stdout
  end
end

describe Instructor do
  subject { described_class.build }

  describe 'with bounds 5x5' do
    context 'invalid place' do
      include_examples 'out_of_bounds', -1, 0
      include_examples 'out_of_bounds', 0, -1
      include_examples 'out_of_bounds', 5, 0
      include_examples 'out_of_bounds', 0, 5
    end

    context 'valid place' do
      it 'returns true from a successful place' do
        expect(subject.place(0, 0, :north)).to be_truthy
      end

      include_examples 'within_bounds', 0, 4
      include_examples 'within_bounds', 3, 2

      it 'allows turning' do
        subject.place(0, 0, :north)
        subject.left
        expect { subject.report }.to output("0,0,WEST\n").to_stdout
        subject.right
        expect { subject.report }.to output("0,0,NORTH\n").to_stdout
      end

      it 'allows moving' do
        subject.place(0, 0, :north)
        subject.move
        expect { subject.report }.to output("0,1,NORTH\n").to_stdout
      end

      it 'allows moving and turning' do
        subject.place(0, 0, :north)
        subject.move
        subject.right
        subject.move
        subject.left
        subject.move
        expect { subject.report }.to output("1,2,NORTH\n").to_stdout
      end

      it 'outputs an error when a move is invalid' do
        subject.place(0, 0, :south)
        expect { subject.move }
          .to output("Error: Invalid move [0, -1]\n").to_stdout
      end
    end
  end

  describe 'with bounds 8x8' do
    subject { described_class.build(width: 8, height: 8) }
    include_examples 'within_bounds', 7, 7
  end
end
