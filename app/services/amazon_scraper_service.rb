class AmazonScraperService < ProductScraperService
  def scrape
    document = fetch_document

    category_name = document.css('#wayfinding-breadcrumbs_feature_div ul.a-unordered-list li span.a-list-item a')[1].text.strip
    category = create_category(category_name)

    product_name = document.css('#productTitle').text.strip
    price = extract_price(document)
    seller_name, full_seller_url = extract_seller_info(document)

    seller_rating = fetch_seller_rating(full_seller_url) if full_seller_url
    additional_info = extract_additional_info(document)

    seller_policy = extract_seller_policy(document)

    images = extract_images(document)

    seller = create_seller(
      name: seller_name,
      rating: seller_rating,
      policy: seller_policy,
      additional_info: additional_info
    )

    create_product(
      name: product_name,
      price: price,
      category: category,
      seller: seller,
      image_urls: images
    )
  end

  private

  def fetch_document
    Nokogiri::HTML(URI.open(@url, "User-Agent" => @headers["User-Agent"]))
  end

  def extract_price(document)
    price_element = document.at_css('.a-price .a-offscreen').text.strip
    price_element.gsub(/[^\d]/, '').to_i
  end

  def extract_seller_info(document)
    seller_name = document.at_css('.tabular-buybox-text-message a')&.text&.strip
    seller_link = document.at_css('.tabular-buybox-text-message a')&.[]('href')
    base_url = "https://www.amazon.in"
    full_seller_url = seller_link ? base_url + seller_link : nil

    [seller_name, full_seller_url]
  end

  def fetch_seller_rating(full_seller_url)
    return nil unless full_seller_url

    sleep(2)
    seller_page = fetch_document(full_seller_url)
    seller_page.at_css('#effective-timeperiod-rating-year-description')&.text&.strip.to_f
  end

  def extract_additional_info(document)
    parent_div = document.at_css('div.a-section.a-spacing-small.a-spacing-top-small')
    return nil unless parent_div

    parent_div.css('table tr').map do |row|
      label = row.at_css('td:nth-child(1) span')&.text.strip
      value = row.at_css('td:nth-child(2) span')&.text.strip
      "#{label}: #{value}" if label && value
    end.compact.join("\n")
  end

  def extract_seller_policy(document)
    payment_option = document.at_css('#PAY_ON_DELIVERY .icon-content span')&.text&.strip
    returns_policy = document.at_css('#RETURNS_POLICY .icon-content span')&.text&.strip
    amazon_delivered = document.at_css('#AMAZON_DELIVERED .icon-content span')&.text&.strip
    free_delivery = document.at_css('#FREE_DELIVERY .icon-content span')&.text&.strip

    [payment_option, returns_policy, amazon_delivered, free_delivery].compact.join(' | ')
  end

  def extract_images(document)
    document.css('#altImages img').map { |img| img['src'] }
  end
end