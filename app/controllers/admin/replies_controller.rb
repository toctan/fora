class Admin::RepliesController < Admin::AdminController
  def destroy
    reply = Reply.find(params[:id])
    redirect_to :back, notice: 'Delete reply successfully' if reply.destroy
  end
end
