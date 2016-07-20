require "spec_helper"

describe BatmanIpsum::Client do
  before do
    FileUtils.rm_f(subject.cache_path)
  end

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

    context "with warm cache" do
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

    context "with empty cache" do
      let(:raw_data) { data.to_json }

      before do
        allow(subject).to receive(:download_data).and_return(raw_data)
      end

      it "read data from BATMAN_IPSUM_DATA_URI" do
        expect(subject).to receive(:download_data).and_return(raw_data)

        subject.fetch_quotes
      end

      context "with invalid JSON" do
        let(:raw_data) { %Q|broken JSON| }

        it "should raise error" do
          expect { subject.fetch_quotes }.to raise_error(JSON::ParserError)
        end
      end
    end
  end
end
