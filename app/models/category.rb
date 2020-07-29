# A Category model represents a category of Lessons
class Category < ApplicationRecord
  has_many :lessons

  validates_presence_of :name
end
