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

  def each_track mode
    @play_token = EightGetter.generate_play_token
    set = retrieve_set :play
    while set["at_end"] == false
      skip_allowed = set["skip_allowed"]
      track = Track.new set["track"]
      yield track

      if mode == :report
        report_track track.id
      end
      next_mode = nil
      if skip_allowed
        next_mode = :skip
      else
        sleep(180)
        next_mode = :next
      end
      set = retrieve_set next_mode
    end
  end

  def first_song
    @play_token = EightGetter.generate_play_token
    set = retrieve_set :play
    Track.new set["track"]
  end

  private

  def populate_user id
    @user = User.new id
  end

  def retrieve_set mode
    json_obj = EightGetter.get_json( "sets/#{@play_token}/#{mode}",
                                     { mix_id: id } )
    json_obj["set"]
  end

  def report_track track_id
    EightGetter.get( "/sets/#{@play_token}/report.json",
                     { mix_id: id, track_id: track_id } )
  end
end
