class AttachmentsController < ApplicationController
  before_action :load_attachment

  def destroy
    if @attachment.attachmentable.user_id == current_user.id
      @attachment.destroy
    end
  end

  private

  def load_attachment
    @attachment = Attachment.find(params[:id])
  end
end