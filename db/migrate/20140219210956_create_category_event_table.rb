class CreateCategoryEventTable < ActiveRecord::Migration
  def change
    create_table :category_events do |t|
      t.belongs_to :category
      t.belongs_to :event
    end
  end
end
