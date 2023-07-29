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
    page_size = 25
    artist = Artist.find(params[:artist_id])
    page = params[:page].to_i
    tracks = get_tracks(artist, page, page_size)
    next_page = tracks.length == page_size ? page + 1 : nil


    render action: :index, locals: {artist:, tracks:, page:, next_page:, page_size:}
  end

  private

  def get_tracks(artist, page, page_size)
    artist.tracks.popularity_ordered.limit(page_size).offset(page_size * page)
  end
end
