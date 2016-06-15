require "open-uri"
require "json"

module BatmanIpsum
  class Client
    BATMAN_IPSUM_DATA_URI = "http://batman-ipsum.com/data/punch_lines.json".freeze

    attr_reader :cache_path

    def initialize(cache_path = "/tmp/batman_ipsum.json")
      raise "Invalid cache_path. #{cache_path.inspect} should be a JSON file." unless cache_path =~ /\.json$/
      @cache_path = cache_path
    end

    def fetch_quotes
      quote = data["texts"].sample
      character = data["characters"].find { |char| char["id"] == quote["id_character"] }["name"]

      [Quote.new(text: quote["text"], character: character)]
    end


    private

    def data
      if File.exists?(cache_path)
        JSON.parse(File.read(cache_path))
      else
        File.open(cache_path, "w+") do |f|
          f.puts open(BATMAN_IPSUM_DATA_URI).read
        end

        data
      end
    end
  end
end
