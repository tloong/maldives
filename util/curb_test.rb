http = Curl.get("http://zip5.5432.tw/zip5json.py?adrs=%E5%8F%B0%E5%8C%97%E5%B8%82%E9%9B%A8%E8%BE%B2%E8%B7%AF")
my_hash = JSON.parse(http.body_str)
puts my_hash["zipcode"]