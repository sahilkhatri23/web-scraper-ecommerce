class ProductUpdateWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5 # Retry 5 times before failing

  def perform
    Product.find_each(batch_size: 100) do |product|
      begin
        ProductScraperService.new(product.url).call
      rescue => e
        Rails.logger.error("Error updating product #{product.id}: #{e.message}")
      end
    end
  end
end
  