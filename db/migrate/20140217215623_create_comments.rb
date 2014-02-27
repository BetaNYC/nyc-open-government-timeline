class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.string :author
      t.belongs_to :event

      t.timestamps
    end
  end
end
