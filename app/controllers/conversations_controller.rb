class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.involving(current_user)
  end

  def create
    if Conversation.one_to_one(params[:sender_id], params[:recipient_id]).present?
      conversation = Conversation.one_to_one(params[:sender_id], params[:recipient_id]).first #@必要ない
    else
      conversation = Conversation.create(conversation_params)
    end

    redirect_to conversation_messages_path(conversation)
  end

private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

end
