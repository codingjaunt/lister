# Lists Controller
class ListsController < ApplicationController
  def index
    @facade = ListsFacade.new(list: new_list,
                              lists: current_user_lists)
  end

  def create
    @facade = ListsFacade.new(list: create_list,
                              lists: current_user_lists)

    respond_to do |format|
      if @facade.valid?
        format.js { flash.now[:notice] = ['List was succesfully created'] }
      else
        format.js { flash.now[:alert] = @facade.list.errors.full_messages }
      end
    end
  end

  def destroy
    @facade = ListsFacade.new(list: destroy_list,
                              lists: current_user_lists)

    respond_to do |format|
      format.js { flash.now[:notice] = ['List was deleted'] }
    end
  end

  private

  def current_user_lists
    ListsFacade.lists(user: current_user)
  end

  def new_list
    ListsFacade.new_list
  end

  def create_list
    ListsFacade.create_list(user: current_user, params: params)
  end

  def destroy_list
    ListsFacade.destroy(id: params[:id], user: current_user)
  end
end
