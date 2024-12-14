class ProductScraperService
  def initialize(url, headers = {})
    @url = url
    @headers = headers
  end

  def call
    domain = extract_domain(@url)
    headers = { "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" }

    case domain
    when "flipkart"
      FlipkartScraperService.new(@url, headers).scrape
    when "amazon"
      AmazonScraperService.new(@url, headers).scrape
    else
      raise "Unsupported domain"
    end
  end

  private

  def extract_domain(url)
    uri = URI.parse(url)
    uri.host.split('.').second
  end

  def create_category(name)
    Category.find_or_create_by(name: name.strip)
  end

  def create_seller(name:, rating:, policy:, additional_info:)
    seller = Seller.find_or_initialize_by(name: name.strip)
    seller.update!(
      rating: rating,
      policy: policy,
      additional_info: additional_info
    )
    seller
  end

  def create_product(name:, price:, category:, seller:, image_urls:)
    product = Product.find_or_initialize_by(url: @url)
    product.update!(
      name: name,
      price: price,
      category: category,
      seller: seller
    )

    image_urls.each do |image_url|
      product.images.attach(io: URI.open(image_url), filename: File.basename(image_url))
    end

    category.update(image: product.images.first.image) if category.image.blank?

    product
  end
end