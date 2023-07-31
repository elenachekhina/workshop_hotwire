class SearchController < ApplicationController
  def index
    q = params[:q]

    if (q.blank? || q.length < 3) && !(params.include? :preview)
      return redirect_back(fallback_location: root_path, alert: "Please, enter at least 3 characters")
    end

    @artists = Artist.search(q).limit(10)
    @albums = Album.search(q).limit(10)
    @tracks = Track.search(q).limit(10)

    if params.include? :preview
      render partial: 'search/preview'
    else
      render action: :index
    end
  end
end
