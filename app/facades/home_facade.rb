# Home Facade
class HomeFacade
  attr_reader :list, :lists

  def initialize(user:, lists_facade: ListsFacade)
    @list = lists_facade.new_list
    @lists = lists_facade.lists(user: user)
  end
end
