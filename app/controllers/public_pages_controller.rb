# PublicPagesController
#   Contains simple routes that do not require autentication
class PublicPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    redirect_to home_show_path if user_signed_in?
  end
end
