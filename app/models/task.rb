class Task < ApplicationRecord
  has_and_belongs_to_many :lessons
  has_many :categories, through: :lessons

  validates_presence_of :name

  def as_json(options = {})
    super(options).merge({
      'categories_ids' => self.categories.map(&:id),
      'lessons_ids' => self.lessons.map(&:id)
    })
  end
end
