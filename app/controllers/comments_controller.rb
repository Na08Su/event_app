class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to event_url(@comment.event_id)
    else
      redirect_to event_url(@comment.event_id), :flash => { :error => '文字を入力してください'}
    end
  end

private
  def comment_params
    params.require(:comment).permit(:body, :user_id, :event_id)
  end
end
