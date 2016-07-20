require "spec_helper"

describe BatmanIpsum::Client do
  subject { BatmanIpsum::Client.new }

  before do
    FileUtils.rm_f(subject.cache_path)
  end

  it "should return a quote" do
    quotes = subject.fetch_quotes

    expect(quotes).not_to be_nil
    expect(quotes).not_to be_empty
    expect(quotes.size).to eq 2

    quote = quotes.first

    expect(quote.text).not_to be_nil
    expect(quote.text).not_to be_empty
    expect(quote.character).not_to be_nil
    expect(quote.character).not_to be_empty
  end
end
