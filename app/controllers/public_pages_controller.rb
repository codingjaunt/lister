# PublicPagesController
#   Contains simple routes that do not require autentication
class PublicPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end
end
