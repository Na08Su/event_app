class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def create
    reservation = Reservation.find_or_initialize_by(user_id: current_user.id, event_id: params[:id])
    if reservation.save
      NoticeMailer.send_event_participation(current_user, reservation).deliver_now # メール送信部
      redirect_to event_path(params[:id]), :flash => { :success => '参加予約完了しました!'}
    else
      flash.now[:error] = 'すでに参加済みです'
      redirect_to event_path(params[:id])
    end
  end

  def destroy
    reservation = current_user.reservations.find_by(event_id: params[:id])

    if reservation
      reservation.destroy
      NoticeMailer.send_event_canceled(current_user, reservation).deliver_now
      redirect_to event_path(params[:id]), :flash => { :success => 'イベントをキャンセルしました'}
    else
      redirect_to event_path(params[:id]), :flash => { :error => 'キャンセルできません'}
    end
  end

end
