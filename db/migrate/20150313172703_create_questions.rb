class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :topic
      t.text :text
      t.has_many :answer
      t.timestamps null: false
    end
  end
end
