class Offer < ActiveRecord::Base
  belongs_to :product

  req = Vacuum.new
    req.associate_tag = ENV['ASSOCIATE_TAG']
    res = req.item_lookup(query: { 'IdType' => 'ASIN', 'ItemId' => asin, 'ResponseGroup' => 'Large'})
    res.to_h["ItemLookupResponse"]["Items"]["Item"]["ItemAttributes"]["Title"]
    # self.offer_listing = product_details["ItemLookupResponse"]["Items"]["Item"]["Offers"]["Offer"]["OfferListing"]
    # self.offer_summary = product_details["ItemLookupResponse"]["Items"]["Item"]["OfferSummary"]
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
