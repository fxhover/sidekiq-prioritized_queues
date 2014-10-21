$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sidekiq'
require 'sidekiq/prioritized_queues'

require 'minitest/autorun'

REDIS = Sidekiq::RedisConnection.create(
  url:       'redis://localhost/15',
  namespace: 'sidekiq_prioritized_queues_test'
)

class MockWorker
  include Sidekiq::Worker
  sidekiq_options priority: -> (arg) { arg * 10 }

  def perform(arg)
  end
end