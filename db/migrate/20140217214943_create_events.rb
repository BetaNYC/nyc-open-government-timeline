class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :type
      t.datetime :date 
      t.string :url 
      t.string :status

      t.timestamps
    end
  end
end
