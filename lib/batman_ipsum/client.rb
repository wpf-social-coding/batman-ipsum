require "open-uri"
require "json"

require "pry"

module BatmanIpsum
  class Client
    BATMAN_IPSUM_DATA_URI = "http://batman-ipsum.com/data/punch_lines.json".freeze

    attr_reader :cache_path

    def initialize(cache_path = "/tmp/batman_ipsum.json")
      @cache_path = cache_path
    end

    def fetch_quotes(characters:)
      if characters == "all"
        quote = data["texts"].sample
        character = data["characters"].find { |char| char["id"] == quote["id_character"] }["name"]
        return [Quote.new(text: quote["text"], character: character)]
      else
        quote = data["texts"].find { |q| q["id_character"] == characters } || {}
        return [Quote.new(text: quote["text"], character: characters)]
      end
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
