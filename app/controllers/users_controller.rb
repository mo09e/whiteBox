class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
   def show
     message_exchange
   end
end
