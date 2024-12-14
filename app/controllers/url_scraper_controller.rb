require 'nokogiri'
require 'open-uri'

class UrlScraperController < ApplicationController
  def new
  end
  
  def create
    url = params[:url]
    product_scraper_service = ProductScraperService.new(url)

    begin
      product = product_scraper_service.call
      redirect_to product_path(product), notice: "Product scraped and saved successfully!"
    rescue => e
      redirect_to root_path, alert: "Error: #{e.message}"
    end
  end
end
