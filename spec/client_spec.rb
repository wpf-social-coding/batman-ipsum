require "spec_helper"

describe BatmanIpsum::Client do
  it "has correct data URI" do
    expect(BatmanIpsum::Client::BATMAN_IPSUM_DATA_URI).to eq "http://batman-ipsum.com/data/punch_lines.json"
  end

  context "initialized" do
    subject { BatmanIpsum::Client.new }

    it "has default cache_path" do
      expect(subject.cache_path).to eq "/tmp/batman_ipsum.json"
    end

    context "with custom cache_path" do
      let(:custom_cache_path) { "custom_cache_path.json" }

      subject { BatmanIpsum::Client.new(custom_cache_path) }

      it "has custom cache_path" do
        expect(subject.cache_path).to eq custom_cache_path
      end

      context "without .json suffix" do
        let(:custom_cache_path) { "invalid_path" }

        it "should raise error" do
          expect { subject }.to raise_error "Invalid cache_path. #{custom_cache_path.inspect} should be a JSON file."
        end
      end
    end
  end

  describe "#fetch_quotes" do
    let(:data) do
      {
        "texts" => [
          { "id_character" => 1, "text" => "Fubar" }
        ],
        "characters" => [
          { "id" => 1, "name" => "Bruce Wayne" }
        ]
      }
    end

    before do
      allow(subject).to receive(:data).and_return(data)
    end

    it "return an array with one quote" do
      expect(subject.fetch_quotes).to be_kind_of(Array)
      expect(subject.fetch_quotes.size).to eq 1
    end

    it "return random quote" do
      quotes = subject.fetch_quotes

      expect(quotes.first.text).to eq "Fubar"
      expect(quotes.first.character).to eq "Bruce Wayne"
    end
  end
end
