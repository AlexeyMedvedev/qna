class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy
	validates :topic, :text, presence: true

  belongs_to :user

  has_many :attachments
end
