class NoticeMailer < ApplicationMailer
  #イベントに参加した時に詳細をメールで送信する

  def send_event_participation(user, reservation)#引数でreservation情報を得る
    @user = user
    @event = Event.find(reservation.event_id).title
    @date = Event.find(reservation.event_id).event_date
    @id = Event.find(reservation.event_id).id
    @url = "https://atndclone123.herokuapp.com/events/#{ @id }"
    mail to: user.email,
         subject: 'イベントに参加しました!'
  end

  def send_event_canceled(user, reservation)
    @user = user
    @event = Event.find(reservation.event_id).title
    @url = 'https://atndclone123.herokuapp.com'
    mail to: user.email,
        subject: 'イベントのキャンセルを完了しました!'
  end

  def send_message(recipient, message)
    @user = User.find(recipient.recipient_id).name
    @id = Message.find(message.conversation_id).id
    @url = "https://atndclone123.herokuapp.com/conversations/#{ @id }/messages"
    mail to: User.find(recipient.recipient_id).email,
         subject: 'メッセージが届きました!'
  end
end
