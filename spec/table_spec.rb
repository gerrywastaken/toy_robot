require 'spec_helper'

shared_examples 'is_invalid' do |x_pos, y_pos|
  it "says #{x_pos},#{y_pos} is invalid" do
    expect(subject.valid_position?(x_pos, y_pos)).to be(false)
  end
end

shared_examples 'is_valid' do |x_pos, y_pos|
  it "says #{x_pos},#{y_pos} is valid" do
    expect(subject.valid_position?(x_pos, y_pos)).to be(true)
  end
end

describe Table do
  describe 'default 5x5' do
    include_examples 'is_valid', 4, 4
    include_examples 'is_invalid', 5, 4
    include_examples 'is_invalid', 4, 5

    include_examples 'is_valid', 0, 0
    include_examples 'is_invalid', -1, 0
    include_examples 'is_invalid', 0, -1
  end

  describe described_class.new(22, 15) do
    include_examples 'is_valid', 21, 14
  end
end
