class Product < ActiveRecord::Base
  has_many :offers

  def get_title(asin)
    req = Vacuum.new
    req.associate_tag = ENV['ASSOCIATE_TAG']
    res = req.item_lookup(query: { 'IdType' => 'ASIN', 'ItemId' => asin, 'ResponseGroup' => 'Large'})
    res.to_h["ItemLookupResponse"]["Items"]["Item"]["ItemAttributes"]["Title"]
  end
end
