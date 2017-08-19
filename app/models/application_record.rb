# Application Record - All Record classes should use this to inherit from
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
