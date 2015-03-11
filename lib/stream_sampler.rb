module StreamSampler
  ##
  # Uses Vitter's reservoir sampling algorithm to take n items
  # without replacement, from a iterable of items of unknown,
  # arbitrary length.
  #
  # The algorithm is O(n) in the length of the iterable. The original
  # paper is at:
  #
  # http://www.cs.umd.edu/~samir/498/vitter.pdf
  #
  def self.reservoir_sample(iterable, n, iteration_method = :each)
    out = []
    return out if n.to_i == 0
    raise ArgumentError, "n must be >= 0" unless n > 0

    iterable.send(iteration_method).with_index do |i, idx|
      if idx < n
        out << i
      else
        j = rand(idx + 1) 
        out[j] = i if j < n
      end
    end

    out
  end

  if defined?(ActiveSupport)
    ##
    # A Concern to add stream sampling methods to ActiveRecord classes,
    # so that you can call the StreamSampler methods in a cleaner way:
    #
    #     YourModel.reservoir_sample(10)
    #
    # as opposed to:
    #
    #     StreamSampler.reservoir_sample(YourModel, 10, :find_each)
    #
    module ActsAsSamplable
      extend ActiveSupport::Concern

      module ClassMethods
        def reservoir_sample(n)
          StreamSampler.reservoir_sample(self, n, :find_each)
        end
      end
    end
  end
end

if defined?(ActiveRecord::Base) && defined?(StreamSampler::ActsAsSamplable)
  ActiveRecord::Base.send(:include, StreamSampler::ActsAsSamplable)
end
