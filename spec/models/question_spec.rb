require 'rails_helper'

RSpec.describe Question, type: :model do
  it {should validate_presence_of(:topic)}
  it {should validate_presence_of(:text)}
  it {should have_many(:answers).dependent(:destroy)}
  it {should belong_to(:user)}
  it {should have_many(:attachments)}
end
