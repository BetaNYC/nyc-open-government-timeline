class AddSubCategoryToEvents < ActiveRecord::Migration
  def up
    add_column :events, :sub_category, :string
  end

  def down
    remove_column :events, :sub_category
  end
end
