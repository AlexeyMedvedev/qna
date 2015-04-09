class ConvertAttachmentToPolymorfic < ActiveRecord::Migration
  def change
    remove_index :attachments, :question_id
    rename_column :attachments, :question_id, :attachmentable_id

    add_column :attachments, :attachmentable_type, :string

    add_index :attachments, [:attachmentable_id, :attachmentable_type]
  end
end
