# StreamSampler - a gem to add stream sampling to Ruby classes.

This gem adds stream sampling (aka reservoir sampling) to Ruby. To use,
add the gem to your Gemfile (or require it explicitly), and call the
`StreamSampler.reservoir_sample` method:

    require 'stream_sampler`
    # takes a 10 item sample from a stream of items:
    items = (1..1000).to_a
    StreamSampler.reservoir_sample(items, 10)

As a special case, if ActiveRecord and ActiveSupport are defined, the stream
sampling methods will be added as class methods on `ActiveRecord::Base`, so you
can do things like this:

    require 'stream_sampler'
    User.where(age: (18..65)).reservoir_sample(10)
