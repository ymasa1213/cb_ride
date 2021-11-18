class MessageMailer < ApplicationMailer
  # 送信先アドレス
  default to: ENV['SEND_TO']

  def received_email(message)
    @message = message
    mail(subject: 'WEBサイトよりメッセージが届きました') do |format|
      format.text
    end
  end
end