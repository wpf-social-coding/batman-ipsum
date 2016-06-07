module BatmanIpsum
  class Quote
    attr_reader :text, :character

    def initialize(text: , character:)
      @text = text
      @character = character
    end
  end
end
