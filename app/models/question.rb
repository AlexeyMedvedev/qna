class Question < ActiveRecord::Base
	validates_presence_of :topic, :text
end
