require 'spec_helper'

describe Robot.build do
  context 'valid' do
    it 'reports current status' do
      subject.place(5, 4, :north)
      expect(subject.report).to eql('5,4,NORTH')
    end

    it 'reports current status' do
      subject.place(2, 7, :south)
      expect(subject.report).to eql('2,7,SOUTH')
    end
  end
end
