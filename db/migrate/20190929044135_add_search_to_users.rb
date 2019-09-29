class AddSearchToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :search, :string
    add_column :users, :search_num, :integer
  end
end
