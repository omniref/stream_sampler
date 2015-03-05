require 'test_helper'

class StreamSamplerTest < ActiveSupport::TestCase
  test "reservoir_sample handles blank and 0 values for n" do
    assert_equal [], StreamSampler.reservoir_sample((1..10).to_a, 0)
    assert_equal [], StreamSampler.reservoir_sample((1..10).to_a, nil)
  end

  test "reservoir_sample handles sample size greater than stream size" do
    items = (1..10).to_a
    assert_equal items, StreamSampler.reservoir_sample(items, 100)
  end

  test "reservoir_sample fails on negative sample sizes" do
    assert_raises(ArgumentError) do
      StreamSampler.reservoir_sample((1..10).to_a, -1)
    end
  end

  test "reservoir_sample produces a sample of at most the specified size" do
    items = (1..100).to_a
    result = StreamSampler.reservoir_sample(items, 10)
    assert_equal 10, result.length
  end
end

class ActsAsSamplableTest < ActiveSupport::TestCase
  def setup
    100.times do |i|
      base_name = ['alice','bob','charlie','daryl'].sample
      User.create(name: "#{base_name}")
    end
  end

  test "reservoir_sample works with scopes and clauses" do
    result = User.reservoir_sample(10)
    assert_equal 10, result.length

    result = User.where(name: 'alice').reservoir_sample(10)
    assert_equal 10, result.length
    assert result.all? { |r| r.name == "alice" }
  end
end
