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
end
