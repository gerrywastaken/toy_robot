require_relative 'spec_helper'

shared_examples 'calls' do |input, expect_command|
  it "calls #{expect_command}" do
    expect(instructor).to receive(expect_command).with(no_args)
    CommandProcessor.build(instructor: instructor, input: input).run
  end
end

shared_examples 'calls_with_args' do |input, expect_command, expect_args|
  it "calls #{expect_command}" do
    expect(instructor).to receive(expect_command).with(*expect_args)
    CommandProcessor.build(instructor: instructor, input: input).run
  end
end

describe CommandProcessor do
  context 'with an instructor' do
    let(:instructor) { instance_double('Instructor') }

    context 'given PLACE with arguments' do
      include_examples 'calls_with_args',
                       ['PLACE 0,0,NORTH'],
                       :place,
                       [0, 0, :north]

      include_examples 'calls_with_args',
                       ['PLACE -1,4,SOUTH'],
                       :place,
                       [-1, 4, :south]
    end

    context 'given commands without arguments' do
      include_examples 'calls', ['MOVE'], :move
      include_examples 'calls', ['LEFT'], :left
      include_examples 'calls', ['RIGHT'], :right
      include_examples 'calls', ['REPORT'], :report
    end

    context 'given multiple commands' do
      it 'calls all commands in order' do
        expect(instructor).to receive(:report).ordered.with(no_args)
        expect(instructor).to receive(:right).ordered.with(no_args)
        expect(instructor).to receive(:left).ordered.with(no_args)
        expect(instructor).to receive(:move).ordered.with(no_args)

        input = %w(REPORT RIGHT LEFT MOVE)

        described_class.build(instructor: instructor, input: input).run
      end
    end
  end
end
