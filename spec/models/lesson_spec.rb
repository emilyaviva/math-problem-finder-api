require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { should belong_to(:category) }
  it { should have_and_belong_to_many(:tasks) }
  it { should validate_presence_of(:name) }
end
