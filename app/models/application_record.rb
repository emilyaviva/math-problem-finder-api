# Top-level class for all app models to inherit from
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
