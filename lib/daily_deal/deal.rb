class DailyDeal::Deal

  attr_accessor :name, :price, :availability, :url

  def self.today
    # puts <<-DOC.gsub /^\s*/, ''
    # 1. Lenovo THINKCENTRE M93 Tiny Desktop       - $399  - Available
    # 2. Philips Bluetooth 2.0 Bookshelf Speakers  - $28   - Available
    # DOC
    self.scrape_deals
  end

  def self.scrape_deals

    deals = []

    deals << self.scrape_woot
    deals << self.scrape_meh

    deals

  end

  def self.scrape_woot
    doc = Nokogiri::HTML(open("https://woot.com"))

    deal = self.new

    deal.name = doc.search("h2.main-title").text.strip
    deal.price = doc.search("#todays-deal span.price").text.strip
    deal.availability = true
    deal.url = doc.search("a.wantone").first.attr("href").strip
    deal
  end

  def self.scrape_meh
    doc = Nokogiri::HTML(open("https://meh.com"))

    deal = self.new

    deal.name = doc.search("section.features h2").text.strip
    deal.price = doc.search("button.buy-button").text.gsub("Buy it.", "").strip
    deal.availability = true
    deal.url = "https://meh.com"
    deal
  end

end
