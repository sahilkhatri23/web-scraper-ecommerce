require 'sidekiq/cron'

Sidekiq::Cron::Job.create(
  name: 'Update Product Details - Every Sunday',
  cron: '0 0 * * SUN',
  class: 'ProductUpdateWorker'
)
