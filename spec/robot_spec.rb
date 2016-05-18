require 'spec_helper'

describe Robot do
  let(:subject) { described_class.build }

  context 'valid' do
    it 'returns true after a place has completed' do
      expect(subject.place(2, 3, :north)).to be(true)
    end

    it 'reports current status' do
      subject.place(6, 4, :north)
      expect(subject.report).to eql('6,4,NORTH')
    end

    it 'reports current status' do
      subject.place(2, 7, :south)
      expect(subject.report).to eql('2,7,SOUTH')
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

  context 'assuming not yet placed' do
    it 'does not mov' do
      subject.move { true }
      expect(subject.report).to eql(nil)
    end
  end
end
