class GalleriesFavoritesController < ApplicationController
  def create
    favorite = current_user.galleries_favorites.create(gallery_id: params[:gallery_id])
    redirect_to galleries_path, notice: "#{favorite.gallery.name}さんをお気に入り登録しました"
  end
  def destroy
    favorite = current_user.galleries_favorites.find_by(id: params[:id]).destroy
    redirect_to galleries_path, notice: "#{favorite.gallery.name}さんをお気に入り解除しました"
  end
end
