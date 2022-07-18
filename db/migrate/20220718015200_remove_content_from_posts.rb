class RemoveContentFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :content, :text
  end
end
