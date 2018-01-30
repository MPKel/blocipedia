class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :authenticate_user!


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def downgrade(id)
    @wikis = Wiki.where(user_id: id)
    @wikis.each do |wiki|
      wiki.private = false
      wiki.save
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
