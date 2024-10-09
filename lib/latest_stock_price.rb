require 'net/http'
require 'json'

class LatestStockPrice
  BASE_URL = 'https://latest-stock-price.p.rapidapi.com'

  def self.price(symbol)
    url = URI("#{BASE_URL}/price/#{symbol}")
    response = fetch_data(url)
    response["price"]
  end

  def self.prices(symbols)
    url = URI("#{BASE_URL}/prices?symbols=#{symbols.join(',')}")
    fetch_data(url)
  end

  def self.price_all
    url = URI("#{BASE_URL}/price/all")
    fetch_data(url)
  end

  private

  def self.fetch_data(url)
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = 'your_api_key'
    request["X-RapidAPI-Host"] = 'latest-stock-price.p.rapidapi.com'

    response = http.request(request)
    JSON.parse(response.body)
  end
end
