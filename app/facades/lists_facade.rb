# Lists Facade
class ListsFacade
  attr_reader :list, :lists

  def initialize(list: :not_set, lists: :not_set)
    @list = list
    @lists = lists
  end

  def valid?
    list.valid?
  end

  class << self
    def lists(user:)
      user.reload.lists
    end

    def new_list(list_model: List)
      list_model.new
    end

    def create_list(params:, user:)
      lists = lists(user: user)
      allowed_params = params.require(:list).permit(:name)

      list = lists.build(allowed_params)
      list.save
      list
    end

    def destroy(id:, user:)
      list = List.find(id)
      list.destroy if user_has_access?(list: list, user: user)
    end

    def user_has_access?(list:, user:)
      list.user == user
    end
  end
end
