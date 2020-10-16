class HomesController < ApplicationController
  def index
    @users = User.all
  end
end
