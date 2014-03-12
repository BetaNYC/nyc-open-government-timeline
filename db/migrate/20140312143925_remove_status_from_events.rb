class RemoveStatusFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :status, :string
  end
end
