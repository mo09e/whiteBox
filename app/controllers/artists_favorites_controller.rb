class ArtistsFavoritesController < ApplicationController
  def create
    favorite = current_user.artists_favorites.create(artist_id: params[:artist_id])
    redirect_to artists_path, notice: "#{favorite.artist.name}さんをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.artists_favorites.find_by(id: params[:id]).destroy
    redirect_to artist_path, notice: "#{favorite.artist.name}さんをお気に入り解除しました"
  end
end
