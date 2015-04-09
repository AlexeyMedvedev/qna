class Answer < ActiveRecord::Base
	belongs_to :question
	validates :text, presence: true

  belongs_to :user

  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments

  def accept
    Answer.transaction do
      Answer.where(question_id: question_id, accepted: true).update_all(accepted: false)
      update(accepted: true)
    end
  end

  scope :by_best, -> { order('accepted DESC') }
end
