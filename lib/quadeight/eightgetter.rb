require 'httparty'

class EightGetter
  include HTTParty

  class << EightGetter
    def api_key= api_key
      @api_key = api_key
      default_params :api_key => api_key
    end

    def api_key
      @api_key
    end
  end

  base_uri '8tracks.com'

  def self.get path
    super("/#{path}.json").body
  end
end
