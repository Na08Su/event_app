class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    set_search
    @search_events = @q.result.order(created_at: :desc) #検索結果、検索されない時には新着投稿順で表示
    @upcoming_events = Event.active.order(event_date: :asc) #直近のイベント
  end

  def show
    @participants = @event.show #名前に違和感があるので修正する
    @comment = Comment.new
    @comments = @event.comments
    @reservation = current_user.reservations.find_by(event_id: @event.id) if user_signed_in? #予約はuserが主になるため
    @organizer = User.find(@event.user_id).name
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, :flash => { :success => 'イベント作成に成功しました！' }
    else
      flash.now[:error] = 'イベント作成に失敗しました、 適切に入力してください'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, :flash => { :success => 'イベント内容を編集しました！' }
    else
      flash.now[:error] = '編集に失敗しました、適切に入力してください'
      render 'edit'
    end
  end

  def destroy
    if @event.destroy
      redirect_to root_url, :flash => { :success => '削除しました！' }
    else
      flash.now[:error] = '削除に失敗しました'
      render 'show'
    end
  end

private

  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :event_date, :deadline, :place, :address, :user_id)
  end
end
