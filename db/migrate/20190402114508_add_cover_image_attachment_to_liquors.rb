class AddCoverImageAttachmentToLiquors < ActiveRecord::Migration[5.1]
  def up
    add_attachment :liquors, :cover_image
  end

  def down
    remove_attachment :liquors, :cover_image
  end
end
