class MessageMailer < ApplicationMailer
  # 送信先アドレス
  default to: Rails.application.credentials.g_mail[:g_mail]

  def received_email(message)
    @message = message
    mail(subject: 'WEBサイトよりメッセージが届きました') do |format|
      format.text
    end
  end
end