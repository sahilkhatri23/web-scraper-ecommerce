require 'rails_helper'

RSpec.describe FlipkartScraperService, type: :service do
  let(:url) { "https://www.flipkart.com/some-product" }
  let(:headers) { { "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" } }
  let(:service) { FlipkartScraperService.new(url, headers) }

  describe '#scrape' do
    it 'scrapes and creates a product' do
      document = Nokogiri::HTML.parse('<html><body></body></html>')

      allow(service).to receive(:fetch_document).and_return(document)
      allow(document).to receive(:css).with('.r2CdBx .R0cyWM').and_return([
        double('Element', text: 'Category 1'),
        double('Element', text: 'Category 2'),
        double('Element', text: 'Electronics')
      ])
      allow(document).to receive(:css).with('h1._6EBuvT .VU-ZEz').and_return(double('Element', text: 'Sample Product'))
      allow(document).to receive(:css).with('.Nx9bqj.CxhGGd').and_return(double('Element', text: '₹1000'))
      allow(document).to receive(:css).with('.ZqtVYK img').and_return([
        double('Element', '[]' => 'http://example.com/image.jpg')
      ])
      allow(document).to receive(:at_css).with('#sellerName span > span').and_return(double('Element', text: 'Seller One'))
      allow(document).to receive(:at_css).with('#sellerName .XQDdHH').and_return(double('Element', text: '4.5'))
      allow(document).to receive(:at_css).with('.YhUgfO').and_return(double('Element', text: 'Returns within 10 days'))
      allow(document).to receive(:at_css).with('.fke1mx').and_return(double('Element', text: 'Some additional info'))

      category = instance_double('Category', name: 'Electronics')
      seller = instance_double('Seller', name: 'Seller One')

      allow(service).to receive(:create_category).and_return(category)
      allow(service).to receive(:create_seller).and_return(seller)
      allow(service).to receive(:create_product).and_return(true)

      service.scrape

      expect(service).to have_received(:create_product).with(
        name: 'Sample Product',
        price: 1000,
        category: category,
        seller: seller,
        image_urls: ['http://example.com/image.jpg']
      )
    end
  end

  describe '#fetch_document' do
    it 'fetches the HTML document for the given URL' do
      document = Nokogiri::HTML.parse('<html><body><h1>Sample</h1></body></html>')
      allow(service).to receive(:fetch_document).and_return(document)

      result = service.send(:fetch_document)

      expect(result).to be_a(Nokogiri::HTML::Document)
    end
  end

  describe '#extract_price' do
    it 'extracts and returns the correct price from the document' do
      document = Nokogiri::HTML.parse('<html><body><span class="Nx9bqj CxhGGd">₹1000</span></body></html>')
      allow(service).to receive(:fetch_document).and_return(document)

      result = service.send(:extract_price, document)

      expect(result).to eq(1000)
    end
  end
end