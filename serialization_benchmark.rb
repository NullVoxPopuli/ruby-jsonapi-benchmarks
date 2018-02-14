# require 'benchmark/ips'
# require 'awesome_print'
# require 'pry-byebug'
# require 'kalibera'
# require 'benchmark-memory'

require 'bundler'
require 'bundler/setup'

Bundler.require(:default)


require_relative './lib/files_under_test'
require_relative './lib/serialization_helper'


benchmarks = %i[ips memory]

GC.disable

ap 'AMS'
ap SerializationHelper.ams(User.first)
ap 'jsonapi-rb'
ap SerializationHelper.jsonapi_rb(User.first)
ap 'fast_jsonapi'
ap SerializationHelper.fast_jsonapi(User.first)

benchmarks.each do |bench|
  Benchmark.send(bench) do |x|
    x.config(time: 10, warmup: 5, stats: :bootstrap, confidence: 95) if x.respond_to?(:config)

    x.report('ams         ') { SerializationHelper.test_render(:ams) }
    x.report('jsonapi-rb  ') { SerializationHelper.test_render(:jsonapi_rb) }
    x.report('fast_jsonapi') { SerializationHelper.test_render(:fast_jsonapi) }

    x.report('ams          eager') { SerializationHelper.test_manual_eagerload(:ams) }
    x.report('jsonapi-rb   eager') { SerializationHelper.test_manual_eagerload(:jsonapi_rb) }
    x.report('fast_jsonapi eager') { SerializationHelper.test_manual_eagerload(:fast_jsonapi) }

    x.compare!
  end
end
