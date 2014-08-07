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

  def self.amazon_item(asin)
    book_asin = '0262062666'
    tv_asin = 'B00BB0ZTMM'
    pots_asin = 'B005J1R22O'
    req = Vacuum.new
    req.associate_tag = ENV['ASSOCIATE_TAG']
    res = req.item_lookup(query: { 'IdType' => 'ASIN', 'ItemId' => asin, 'ResponseGroup' => 'Large'})
    product_details = res.to_h
    offer_listing = product_details["ItemLookupResponse"]["Items"]["Item"]["Offers"]["Offer"]["OfferListing"]
    offer_summary = product_details["ItemLookupResponse"]["Items"]["Item"]["OfferSummary"]
    title = product_details["ItemLookupResponse"]["Items"]["Item"]["ItemAttributes"]["Title"]
    binding.pry
  end
end
