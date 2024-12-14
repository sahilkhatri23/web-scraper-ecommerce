class FlipkartScraperService < ProductScraperService
  def scrape
    document = fetch_document(@url)

    category_name = document.css('.r2CdBx .R0cyWM').map(&:text)[2].strip
    category = create_category(category_name)

    product_name = document.css('h1._6EBuvT .VU-ZEz').text.strip
    price = extract_price(document)
    seller_name, seller_rating, seller_policy, additional_info = extract_seller_info(document)

    seller = create_seller(
      name: seller_name,
      rating: seller_rating,
      policy: seller_policy,
      additional_info: additional_info
    )

    images = extract_images(document)

    create_product(
      name: product_name,
      price: price,
      category: category,
      seller: seller,
      image_urls: images
    )
  end

  private

  def fetch_document(url)
    Nokogiri::HTML(URI.open(url, "User-Agent" => @headers["User-Agent"]))
  end

  def extract_price(document)
    price_element = document.css('.Nx9bqj.CxhGGd').text.strip
    price_element.gsub(/[^\d]/, '').to_i
  end

  def extract_seller_info(document)
    seller_name = document.at_css('#sellerName span > span')&.text.strip
    seller_rating = document.at_css('#sellerName .XQDdHH')&.text.strip.to_f
    seller_policy = document.at_css('.YhUgfO')&.text.strip
    additional_info = document.at_css('.fke1mx')&.text.strip

    [seller_name, seller_rating, seller_policy, additional_info]
  end

  def extract_images(document)
    document.css('.ZqtVYK img').map { |img| img['src'] }
  end
end