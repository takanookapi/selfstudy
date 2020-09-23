class CommentsController < ApplicationController

  def create
    Comment.create(comment_params)
      redirect_to  root_path
  end

  def destroy
    redirect_to root_path unless user_signed_in? || current_user.id == @time_report.user_id && current_user.id == comment.user_id
    @comment = Comment.find(params[:time_report_id])
    if @comment.destroy
      redirect_to time_report_path
    else
      redirect_to root_path
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id).merge(time_report_id: params[:time_report_id])
  end
end
