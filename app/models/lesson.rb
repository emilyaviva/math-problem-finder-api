# A Lesson model refers to a Montessori lesson
class Lesson < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :tasks

  validates_presence_of :name

  def as_json(options = {})
    super(options).merge({
      'category_id' => category.id,
      'tasks_ids' => tasks.map(&:id)
    })
  end
end
