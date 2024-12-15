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
cd ecommerce-scraper