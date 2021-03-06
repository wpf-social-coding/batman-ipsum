require "open-uri"
require "json"

module BatmanIpsum
  class Client
    BATMAN_IPSUM_DATA_URI = "http://batman-ipsum.com/data/punch_lines.json".freeze

    attr_reader :cache_path

    def initialize(cache_path = "/tmp/batman_ipsum.json")
      @cache_path = cache_path
    end

    def fetch_quotes
      data["texts"].take(2).each_with_object([]) do |quote, quotes|
        character = data["characters"].find { |char| char["id"] == quote["id_character"]}["name"]

        quotes << Quote.new(text: quote["text"], character: character)
      end
    end


    private

    def data
      if File.exists?(cache_path)
        JSON.parse(File.read(cache_path))
      else
        File.open(cache_path, "w+") do |f|
          f.puts download_data
        end

        data
      end
    end

    def download_data
      open(BatmanIpsum::Client::BATMAN_IPSUM_DATA_URI).read
    end
  end
end
