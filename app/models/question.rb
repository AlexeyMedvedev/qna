class Question < ActiveRecord::Base
	has_many :answer
	validates_presence_of :topic, :text
end
