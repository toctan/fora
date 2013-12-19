class Admin::RepliesController < Admin::AdminController
  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy!

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
