class PlayerCommand < ApplicationCommand
  prevent_controller_action

  def play
    track_id = element.data.track
    track = Track.find(track_id)

    if current_user&.live_station&.live?
      station = current_user.live_station
      station.play_now(track)

      Turbo::StreamsChannel.broadcast_update_to station, target: :player, partial: "player/player", locals: {station:, track:}

      turbo_stream.update("player", partial: "player/player", locals: {station:, track:, live: true})
      turbo_stream.update(dom_id(station, :queue), partial: "live_stations/queue", locals: {station:})
    else
      turbo_stream.update("player", partial: "player/player", locals: {track:})
    end
  end

  def pause
    station = current_user.live_station

    Turbo::StreamsChannel.broadcast_stream_to station, content: "<turbo-stream attribute=\"data-player-command-value\" value=\"pause\" action=\"set_attribute\" targets=\".player\"><template></template></turbo-stream>"
    # Turbo::StreamsChannel.broadcast_stream_to station, content: turbo_stream.set_attribute(".player", "data-player-command-value", "pause")
    # Такой способ не завелся, разница с первым заключается в том, что во втором способе в атрибуте дата передается массив
  end

  def continue
    station = current_user.live_station

    Turbo::StreamsChannel.broadcast_stream_to station, content: "<turbo-stream attribute=\"data-player-command-value\" value=\"continue\" action=\"set_attribute\" targets=\".player\"><template></template></turbo-stream>"
  end
end
