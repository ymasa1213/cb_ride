class User::MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    # 入力画面
    @message = Message.new
  end

  def confirm
    # 入力確認
    @message = Message.new(message_params)
    if @message.valid?
      # 成功なら確認画面へ
      render :action => 'confirm'
    else
      # 失敗なら入力画面へ
      flash[:notice] = "必要事項を入力してください"
      render :action => 'index'
    end
  end

  def back
    # 内容を保存したまま戻る
    @message = Message.new(message_params)
    render :action => 'index'
  end

  def done
    # メール送信
    @message = Message.new(message_params)
    if params[:back]
      render :action => 'index'
    else
      # 今すぐ送信
      MessageMailer.received_email(@message).deliver_now
      render :action => 'done'
    end
  end

  private
  def message_params
    params.require(:message).permit(:name, :email, :content)
  end

end