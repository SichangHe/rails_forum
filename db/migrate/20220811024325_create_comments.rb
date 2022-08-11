class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :commentable, null: false, polymorphic: true
      t.integer :status

      t.timestamps
    end
  end
end
