require 'spec_helper'

describe Robot do
  let(:subject) { described_class.build }

  context 'invalid' do
    it 'raises exception if asked to face in an invalid direction' do
      expect { subject.place(5, 4, :magnetic_north) }
        .to raise_error(InvalidDirextion)
    end

    it 'raises exception if asked to face in an invalid direction' do
      expect { subject.place(5, 4, :magnetic_north) }
        .to raise_error(InvalidDirextion)
    end
  end

  describe 'before placed' do
    it 'returns nil if asked to report ' do
      expect(subject.report).to be_nil
    end

    it 'returns nil if asked to turn left' do
      expect(subject.left).to be_nil
    end

    it 'returns nil if asked to turn right' do
      expect(subject.right).to be_nil
    end

    it 'returns nil if asked to move' do
      expect(subject.move { true } ).to be_nil
    end
  end

  context 'valid' do
    it 'returns true after a place has completed' do
      expect(subject.place(2, 3, :north)).to be_truthy
    end

    it 'reports current status' do
      subject.place(6, 4, :north)
      expect(subject.report).to eql('6,4,NORTH')
    end

    it 'reports current status' do
      subject.place(2, 7, :south)
      expect(subject.report).to eql('2,7,SOUTH')
    end

    it 'can turn left' do
      subject.place(0, 0, :east)
      expect(subject.left).to be(:north)
      expect(subject.report).to eql('0,0,NORTH')
      expect(subject.left).to be(:west)
      expect(subject.left).to be(:south)
      expect(subject.left).to be(:east)
      expect(subject.report).to eql('0,0,EAST')
    end

    it 'can turn right' do
      subject.place(0, 0, :west)
      expect(subject.right).to be(:north)
      expect(subject.report).to eql('0,0,NORTH')
      expect(subject.right).to be(:east)
      expect(subject.right).to be(:south)
      expect(subject.right).to be(:west)
      expect(subject.report).to eql('0,0,WEST')
    end
  end

  context 'assuming valid move' do
    describe 'can move' do
      it 'north' do
        subject.place(0, 0, :north)
        subject.move { true }
        expect(subject.report).to eql('0,1,NORTH')
      end

      it 'south' do
        subject.place(0, 4, :south)
        subject.move { true }
        expect(subject.report).to eql('0,3,SOUTH')
      end

      it 'east' do
        subject.place(0, 0, :east)
        subject.move { true }
        expect(subject.report).to eql('1,0,EAST')
      end

      it 'west' do
        subject.place(4, 0, :west)
        subject.move { true }
        expect(subject.report).to eql('3,0,WEST')
      end
    end
  end

  context 'assuming invalid move' do
    it 'does not move' do
      subject.place(0, 0, :north)
      expect { subject.move { false } }.to raise_error(InvalidMove)
    end
  end
end
