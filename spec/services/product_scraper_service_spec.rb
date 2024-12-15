require 'rails_helper'

RSpec.describe ProductScraperService, type: :service do
  let(:url) { "https://www.amazon.in/dp/B08VJ1FF9G" }
  let(:headers) { { "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" } }
  let(:service) { ProductScraperService.new(url, headers) }

  describe '#call' do
    context 'when domain is flipkart' do
      let(:url) { "https://www.flipkart.com/some-product" }

      it 'calls FlipkartScraperService' do
        flipkart_scraper_double = instance_double(FlipkartScraperService)
        allow(FlipkartScraperService).to receive(:new).and_return(flipkart_scraper_double)
        allow(flipkart_scraper_double).to receive(:scrape)

        service.call

        expect(FlipkartScraperService).to have_received(:new).with(url)
        expect(flipkart_scraper_double).to have_received(:scrape)
      end
    end

    context 'when domain is amazon' do
      let(:url) { "https://www.amazon.in/dp/B08VJ1FF9G" }

      it 'calls AmazonScraperService' do
        amazon_scraper_double = instance_double(AmazonScraperService)
        allow(AmazonScraperService).to receive(:new).and_return(amazon_scraper_double)
        allow(amazon_scraper_double).to receive(:scrape)

        service.call

        expect(AmazonScraperService).to have_received(:new).with(url, headers)
        expect(amazon_scraper_double).to have_received(:scrape)
      end
    end

    context 'when domain is unsupported' do
      let(:url) { "https://www.someotherdomain.com/product" }

      it 'raises an error' do
        expect { service.call }.to raise_error("Unsupported domain")
      end
    end
  end

  describe '#create_category' do
    context 'when category does not exist' do
      it 'creates a new category' do
        category_name = "Electronics"
        category = service.send(:create_category, category_name)

        expect(category).to be_persisted
        expect(category.name).to eq(category_name.strip)
      end
    end

    context 'when category exists' do
      it 'finds an existing category' do
        category = create(:category, name: "Electronics")
        found_category = service.send(:create_category, "Electronics")

        expect(found_category).to eq(category)
      end
    end
  end

  describe '#create_seller' do
    let(:seller_name) { "Seller One" }
    let(:seller_rating) { 4.5 }
    let(:seller_policy) { "30-day return" }
    let(:seller_additional_info) { "Ships worldwide" }

    context 'when seller does not exist' do
      it 'creates a new seller' do
        seller = service.send(:create_seller, name: seller_name, rating: seller_rating, policy: seller_policy, additional_info: seller_additional_info)

        expect(seller).to be_persisted
        expect(seller.name).to eq(seller_name)
        expect(seller.rating).to eq(seller_rating)
        expect(seller.policy).to eq(seller_policy)
        expect(seller.additional_info).to eq(seller_additional_info)
      end
    end

    context 'when seller exists' do
      it 'updates the existing seller' do
        existing_seller = create(:seller, name: seller_name)
        seller = service.send(:create_seller, name: seller_name, rating: seller_rating, policy: seller_policy, additional_info: seller_additional_info)

        expect(seller.rating).to eq(seller_rating)
        expect(seller.policy).to eq(seller_policy)
        expect(seller.additional_info).to eq(seller_additional_info)
      end
    end
  end

  describe '#create_product' do
    let(:category) { create(:category) }
    let(:seller) { create(:seller) }
    let(:image_path) { Rails.root.join('spec', 'fixtures', 'files', 'sample_image.png') }
    let(:image) { fixture_file_upload(image_path, 'image/png') }
    let(:image_urls) { [image] }

    context 'when creating a new product' do
      it 'creates a new product' do
        product = service.send(
          :create_product,
          name: "Sample Product",
          price: 1000,
          category: category,
          seller: seller,
          image_urls: image_urls
        )

        expect(product).to be_persisted
        expect(product.name).to eq("Sample Product")
        expect(product.price).to eq(1000)
        expect(product.category).to eq(category)
        expect(product.seller).to eq(seller)
        expect(product.images.count).to eq(1)
      end
    end
  end
end