class TracksController < ApplicationController
  def play
    track = Track.find(params[:id])

    session[:track_id] = track.id

    render partial: "shared/player", locals: {track:}
  end

  def play_next
    track = Track.find(params[:id])

    # Make sure we do not cache the request
    expires_now

    next_track = track.album.tracks.order(position: :asc).where("position > ?", track.position).first

    session[:track_id] = next_track.id if next_track

    render partial: "shared/player", locals: {track: next_track}
  end

  def index
    puts "In index"
    artist = Artist.find(params[:artist_id])
    page = params[:page].to_i
    tracks = get_tracks(artist, page)
    next_page = tracks.length == 5 ? page + 1 : nil

    render action: :index, locals: {artist:, tracks:, page:, next_page:}
  end

  private

  def get_tracks(artist, page)
    artist.tracks.popularity_ordered.limit(5).offset(5 * page)
  end
end
