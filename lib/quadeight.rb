require 'quadeight/version'
require 'quadeight/client.rb'
require 'quadeight/eightgetter.rb'
require 'quadeight/mix.rb'
require 'quadeight/user.rb'
require 'quadeight/helpers.rb'
require 'quadeight/mixset.rb'
require 'quadeight/track.rb'

module Quadeight
  def self.create_client options
    Client.new options
  end
end
