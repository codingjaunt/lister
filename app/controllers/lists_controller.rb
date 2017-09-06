# Lists Controller
class ListsController < ApplicationController
  def index
    @facade = ListsFacade.index(current_user)
  end

  def create
    @facade = ListsFacade.create(user: current_user, params: params)

    respond_to do |format|
      if @facade.valid?
        format.html { redirect_to lists_path, notice: 'List was successfully created' }
        format.js
      else
        format.html { render action: 'new' }
      end
    end
  end
end
