# Ecommerce Scraper

This project is an Ecommerce Scraper built using Ruby on Rails, where you can input the URL of products from supported ecommerce platforms (Flipkart and Amazon). The product details such as name, price, and image are scraped from the provided URLs and stored in the database. The project uses the Nokogiri gem for web scraping and Selenium WebDriver for handling dynamic content when scraping.

## Features
* Scrape product details from Flipkart and Amazon.
* Store the scraped product details in the database.
* Dynamic handling of content using Selenium WebDriver.
* Simple and user-friendly interface for adding URLs and initiating scraping.

## Requirements
Before setting up the project, make sure you have the following installed:

* Ruby (version 3.x)
* Rails (version 7.x)
* Node.js and Yarn (for managing JavaScript dependencies)
* PostgreSQL (for the database)
* Bundler (for managing Ruby gems)

## Installation

Follow these steps to clone and set up the project:

### 1. Clone the Repository
Clone the repository to your local machine using the following command:

```bash
git clone https://github.com/sahilkhatri23/web-scraper-ecommerce.git
cd web-scraper-ecommerce
```

### 2. Install Dependencies
Install the necessary Ruby gems, JavaScript packages, and set up your database:

```bash
bin/setup
```

This command will:

* Install all the required Ruby gems specified in the ```Gemfile```.
* Install Node.js dependencies.
* Set up the database by creating and migrating the necessary tables.

### 3. Run the Server
Now that everything is set up, you can start the Rails server with:

```bash
bin/dev
```

This will start the server at ```http://localhost:3000```. You can now visit the website in your browser and start scraping products by entering URLs.

## Usage
Once the server is running, you can:

* Go to ```http://localhost:3000``` to access the homepage.
* Click on let's scrape or View available products.
* Enter a product URL from **Flipkart** or **Amazon** into the provided field.
* Click the **Scrape** button.
* The product details (name, price, and image) will be scraped from the given URL and stored in the database.

## Technologies Used

* **Ruby on Rails**: The web application framework.
* **Nokogiri**: For parsing HTML and extracting product details.
* **Selenium WebDriver**: For handling dynamic pages.
* **PostgreSQL**: For database management.
* **TailwindCSS**: For styling the frontend.

## Troubleshooting

* If you encounter issues with Selenium WebDriver, ensure that the appropriate browser driver is installed and accessible from your system’s PATH.
* If you face issues with bundle installation, try running ```gem install bundler``` before executing ```bundle install```.

## Contributing

Feel free to fork this project and create pull requests. If you find any bugs or have feature requests, open an issue, and I’ll be happy to review and merge your changes.