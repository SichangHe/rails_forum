class AddNameAndXpToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, default: 'Anonymous', null: false
    add_column :users, :xp, :integer, default: 0, null: false
  end
end
