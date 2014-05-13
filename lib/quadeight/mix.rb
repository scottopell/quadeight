class Mix
  attr_reader :user

  def initialize json_obj
    user_pop_proc = Proc.new do |obj, key, value|
      if key == 'user_id'
        obj.send( :populate_user, value )
      end
      key == 'user_id'
    end
    Helpers.populate_instance_variables self, json_obj, user_pop_proc
  end

  def populate_user id
    @user = User.new id
  end

  def each_song mode
    play_token = EightGetter.generate_play_token
    json_obj = EightGetter.get_json( "sets/#{play_token}/play",
                                     { mix_id: id } )
    set = json_obj["set"]
    while set["at_end"] == false
      skip_allowed = set["skip_allowed"]
      track = Track.new set["track"]
      yield track
      if mode == :report
        EightGetter.get( "/sets/#{play_token}/report.json",
                         { mix_id: id, track_id: track.id } )
      end
      next_mode = nil
      if skip_allowed
        next_mode = :skip
      else
        next_mode = :next
      end
      set = EightGetter.get_json( "sets/#{play_token}/#{next_mode}",
                                  { mix_id: id } )
    end
  end
end
