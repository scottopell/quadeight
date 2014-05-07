class EightGetter
  include HTTParty
  base_uri 'http://8tracks.com/'
  headers "X-Api-Key=#{@api_key}"
  format :json

  def initialize api_key
    @api_key = api_key
  end
end
