class Product < ActiveRecord::Base
  def self.amazon_search
    req = Vacuum.new
    req.configure(
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      associate_tag: ENV['ASSOCIATE_TAG']
      )

    params = {
    'SearchIndex' => 'Books',
    'Keywords'    => 'Architecture'
    }
  res = req.item_search(query: params)
  products = res.to_h
  binding.pry
  end

  def add_amazon_attributes!(asin)
    #####################################################
    # NEED TO SAVE ATTRIBUTES TO PRODUCT IN THIS METHOD #
    #####################################################
    req = Vacuum.new
    req.associate_tag = ENV['ASSOCIATE_TAG']
    res = req.item_lookup(query: { 'IdType' => 'ASIN', 'ItemId' => asin, 'ResponseGroup' => 'Large'})
    product_details = res.to_h
    self.offer_listing = product_details["ItemLookupResponse"]["Items"]["Item"]["Offers"]["Offer"]["OfferListing"]
    self.offer_summary = product_details["ItemLookupResponse"]["Items"]["Item"]["OfferSummary"]
    self.title = product_details["ItemLookupResponse"]["Items"]["Item"]["ItemAttributes"]["Title"]
  end

  def initial_price
    offer_summary.to_h["LowestNewPrice"]["FormattedPrice"]
  end

  def current_price
    req = Vacuum.new
    req.associate_tag = ENV['ASSOCIATE_TAG']
    res = req.item_lookup(query: { 'IdType' => 'ASIN', 'ItemId' => self.asin, 'ResponseGroup' => 'Large'})
    res.to_h["ItemLookupResponse"]["Items"]["Item"]["OfferSummary"]["LowestNewPrice"]["FormattedPrice"]
  end
end
