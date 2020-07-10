require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should have_and_belong_to_many(:lessons) }
  it { should have_many(:categories) }
  it { should validate_presence_of(:name) }
end
