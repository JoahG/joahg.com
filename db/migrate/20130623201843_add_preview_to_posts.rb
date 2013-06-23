class AddPreviewToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :preview, :string
  end
end
