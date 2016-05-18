require 'spec_helper'

describe Instructor do
  subject { described_class.build }

  it 'returns true from a successful place' do
    expect(subject.place(0, 0, :north)).to be(true)
  end

  it 'allows turning' do
    subject.place(0, 0, :north)
    subject.left
    expect { subject.report }.to output("0,0,WEST\n").to_stdout
    subject.right
    expect { subject.report }.to output("0,0,NORTH\n").to_stdout
  end

  it 'outputs an error when a move is invalid' do
    subject.place(0, 0, :south)
    expect { subject.move }.to output("Error: Invalid move [0, -1]\n").to_stdout
  end

  it 'allows moving' do
    subject.place(0, 0, :north)
    subject.move
    expect { subject.report }.to output("0,1,NORTH\n").to_stdout
  end
end
