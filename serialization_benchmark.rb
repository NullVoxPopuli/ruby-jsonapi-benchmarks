# require 'benchmark/ips'
# require 'awesome_print'
# require 'pry-byebug'
# require 'kalibera'
# require 'benchmark-memory'

require 'bundler'
require 'bundler/setup'

Bundler.require(:default)

ENV['USE_DEFAULTS'] ||= 'true'
ENV['TEST_OUTPUT'] ||= nil

require_relative './db/setup'
require_relative './lib/files_under_test'
require_relative './lib/serialization_helper'
require_relative './lib/configurations'

# require_relative './db/seeds'

benchmarks = %i[ips memory]

GC.disable

def compare_output(data)
  ap 'AMS'
  ap SerializationHelper.ams(data)
  ap 'jsonapi-rb'
  ap SerializationHelper.jsonapi_rb(data)
  ap 'fast_jsonapi'
  ap SerializationHelper.fast_jsonapi(data)

  exit
end

[3].each do |x|
  user_list = []
  x.times {

    user = User.create(first_name: 'Short', last_name: 'abcdefghijklmnopqrstuvwxy', birthday: 100.years.ago)

    1000.times { Post.create(user_id: user.id, title: 'Some Post', body: 'awesome_content') }
    user_list << user
  }

  if ENV['TEST_OUTPUT']
    compare_output(User.all)
  end


  benchmarks.each do |bench|
    Benchmark.send(bench) do |x|
      x.config(time: 10, warmup: 5, stats: :bootstrap, confidence: 95) if x.respond_to?(:config)

      # x.report('ams         ') { SerializationHelper.test_render(:ams) }
      # x.report('jsonapi-rb  ') { SerializationHelper.test_render(:jsonapi_rb) }
      # x.report('fast_jsonapi') { SerializationHelper.test_render(:fast_jsonapi) }

      x.report('ams          eager') { SerializationHelper.test_manual_eagerload(:ams, user_list) }
      x.report('jsonapi-rb   eager') { SerializationHelper.test_manual_eagerload(:jsonapi_rb, user_list) }
      x.report('fast_jsonapi eager') { SerializationHelper.test_manual_eagerload(:fast_jsonapi, user_list) }

      x.compare!
    end
  end
end
