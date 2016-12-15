# Preview all emails at http://localhost:3000/rails/mailers/notice_mailer
class NoticeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notice_mailer/send_event_participation
  def send_event_participation
    NoticeMailer.send_event_participation
  end

end
