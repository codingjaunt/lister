# Home Controller
class HomeController < ApplicationController
  def show
    @facade = HomeFacade.new(user: current_user)
  end
end
