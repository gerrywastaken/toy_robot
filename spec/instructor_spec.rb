require 'spec_helper'

describe Instructor do
  subject { described_class.build }

  it 'returns true from a successful place' do
    expect(subject.place(0, 0, :north)).to be(true)
  end

  it 'allows moving' do
    subject.place(0, 0, :north)
    subject.move
    expect { subject.report }.to output("0,1,NORTH\n").to_stdout
  end
end
