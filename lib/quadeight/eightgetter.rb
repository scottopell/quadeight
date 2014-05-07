require 'httparty'

class EightGetter
  include HTTParty

  class << EightGetter
    def api_key= api_key
      @api_key = api_key
    end

    def api_key
      @api_key
    end
  end

  base_uri '8tracks.com'
  default_params :api_key => EightGetter.api_key
  debug_output $stdout

  def self.get path
    super "/#{path}.json"
  end
end
