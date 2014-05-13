class MixSet
  attr_reader :mixes
  def initialize json_mix_set
    Helpers.populate_instance_variables self, json_mix_set

    json_mixes = json_mix_set['mixes']
    @mixes = []
    json_mixes.each do |jm|
      @mixes << Mix.new(jm)
    end
  end
end
