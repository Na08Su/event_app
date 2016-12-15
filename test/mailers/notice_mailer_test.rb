require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "send_event_participation" do
    mail = NoticeMailer.send_event_participation
    assert_equal "Send event participation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
