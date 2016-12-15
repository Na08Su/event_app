class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_conversation

  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @another = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order("created_at DESC")
    else
      redirect_to conversations_path, :flash => { :error => '権限がありません!' }
    end
  end

  def create
    @message = @conversation.messages.new(message_params)
    @messages = @conversation.messages.order("created_at DESC")

    if @message.save
      NoticeMailer.send_message(@conversation, @message).deliver_now
      respond_to do |format|
        format.js
      end
    #   redirect_to conversation_messages_path(@conversation)
    else
      redirect_to conversation_messages_path(@conversation), :flash => { :error => '文字を入力してください'}
    end
  end

private
  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end

end
