class Lesson < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :tasks

  def as_json(options = {})
    super(options).merge({
      'category_id' => self.category.id,
      'tasks_ids' => self.tasks.map(&:id)
    })
  end
end
