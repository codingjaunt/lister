# Lists Facade
class ListsFacade
  attr_reader :list, :lists

  def initialize(list:, lists:)
    @list = list
    @lists = lists
  end

  def valid?
    list.valid?
  end

  def self.index(user:)
    new(lists: lists(user: user),
        list: new_list)
  end

  def self.lists(user:)
    user.lists
  end

  def self.new_list(list_model: List)
    list_model.new
  end

  def self.create(user:, params:)
    lists = lists(user: user)

    new(list: create_list(lists: lists, params: params),
        lists: lists.reload)
  end

  def self.create_list(lists:, params:)
    allowed_params = params.require(:list).permit(:name)

    list = lists.build(allowed_params)
    list.save
    list
  end
end
