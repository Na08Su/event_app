class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  def show
    @events = @user.events#userが作成したイベント一覧
    @reservations = @user.reservations#userの参加予約しているイベント一覧
  end

private
  def find_user
    @user = User.find(params[:id])
  end
end
