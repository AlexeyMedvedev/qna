require 'rails_helper'

RSpec.describe Question, type: :model do
  it {should validate_presence_of(:topic)}
  it {should validate_presence_of(:text)}
end
