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
  debug_output $stderr

  def self.get path, args = {}
    super(path, :query => args).body
  end

  def self.get_json path, args = {}
    JSON.parse( get("/#{path}.json", args) )
  end

  def self.generate_play_token
    get_json("sets/new")["play_token"]
  end
end
