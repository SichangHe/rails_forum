class AddTagsBackToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :tags, :string
  end
end
