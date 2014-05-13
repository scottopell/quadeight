require 'httparty'

class EightGetter
  include HTTParty

  class << EightGetter
    def api_key= api_key
      @api_key = api_key
      headers 'X-Api-Key' => api_key
    end

    def api_key
      @api_key
    end
  end

  base_uri '8tracks.com'
  headers 'X-Api-Version' => '3'

  def self.get path, args = {}
    super("/#{path}.json", :query => args).body
  end

  def self.get_json path, args = {}
    JSON.parse(get(path, args))
  end
end
