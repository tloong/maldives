module QualityTestingsHelper
  def hash_to_querystring(hash)
    hash.keys.inject('') do |query_string, key|
      query_string << ' and ' unless key == hash.keys.first
      query_string << "#{key} like '%#{hash[key]}%'"
    end
  end
end
