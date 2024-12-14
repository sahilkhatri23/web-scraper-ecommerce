require "test_helper"

class UrlScraperControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get url_scraper_new_url
    assert_response :success
  end

  test "should get create" do
    get url_scraper_create_url
    assert_response :success
  end
end
