class ApplicationMailer < ActionMailer::Base# 全メーラーの共通設定
  default from: "noreply@example.com",
          bcc:      "sample+sent@example.com",
          reply_to: "sample+reply@example.com"
  #layout 'mailer'
end
