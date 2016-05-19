require 'spec_helper'

describe Instructor do
  subject { described_class.build }

  describe 'with bounds 5x5' do
    context 'invalid place' do
      it 'does not allow placing at -1 on x axis' do
        expect { subject.place(-1, 0, :north) }
          .to raise_error(
            OutsideBounds,
            'Error: coordinates are not on the table [-1,0]'
          )
      end

      it 'does not allow placing at -1 on y axis' do
        expect { subject.place(0, -1, :north) }
          .to raise_error(
            OutsideBounds,
            'Error: coordinates are not on the table [0,-1]'
          )
      end

      it 'does not allow placing at 5 on x axis' do
        expect { subject.place(5, 0, :north) }
          .to raise_error(
            OutsideBounds,
            'Error: coordinates are not on the table [5,0]'
          )
      end

      it 'does not allow placing at 5 on y axis' do
        expect { subject.place(0, 5, :north) }
          .to raise_error(
            OutsideBounds,
            'Error: coordinates are not on the table [0,5]'
          )
      end
    end

    context 'valid place' do
      it 'returns true from a successful place' do
        expect(subject.place(0, 0, :north)).to be_truthy
      end

      it 'allows placing at 0,4' do
        subject.place(0, 4, :north)
        expect { subject.report }.to output("0,4,NORTH\n").to_stdout
      end

      it 'allows placing at 3,2' do
        subject.place(3, 2, :north)
        expect { subject.report }.to output("3,2,NORTH\n").to_stdout
      end

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
    it 'does allows us to place at 7,7' do
      subject.place(7, 7, :north)
      expect { subject.report }.to output("7,7,NORTH\n").to_stdout
    end
  end
end
