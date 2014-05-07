require "quadeight/version"
require "quadeight/client.rb"
require "quadeight/eightgetter.rb"

module Quadeight
  def Quadeight.hello
    'world'
  end

  def self.create_client options
    Client.new options
  end
end
